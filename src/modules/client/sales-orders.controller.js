const prisma = require('../../utils/prisma');
const NotificationService = require('../../utils/notification.service');

const getSalesOrders = async (req, res) => {
  try {
    // req.user.id is the Client's ID (from the Client table) when role === CLIENT
    const whereClause = req.user.role === 'CLIENT'
      ? { clientId: req.user.id }
      : (req.user.companyId ? { companyId: req.user.companyId } : {});

    const orders = await prisma.salesOrder.findMany({
      where: whereClause,
      include: {
        items: { include: { product: true } }
      },
      orderBy: { createdAt: 'desc' }
    });
    res.json(orders);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

const createSalesOrder = async (req, res) => {
  try {
    const { clientId, items, deliveryAddress, notes, poNumber, priority } = req.body; // items: [{ productId, quantity }]

    if (!items || !Array.isArray(items) || items.length === 0) {
      return res.status(400).json({ message: 'Items are required' });
    }

    // Ensure we have a valid clientId to satisfy the foreign key constraint
    let effectiveClientId = clientId;
    if (!effectiveClientId) {
      const existingClient = await prisma.client.findFirst({
        where: { ...(req.user.companyId ? { companyId: req.user.companyId } : {}) }
      });
      if (existingClient) {
        effectiveClientId = existingClient.id;
      } else {
        const newClient = await prisma.client.create({
          data: {
            name: "Default Client",
            ...(req.user.companyId ? { companyId: req.user.companyId } : {})
          }
        });
        effectiveClientId = newClient.id;
      }
    }

    let totalCost = 0;
    
    // Validate products exist and calculate total (using wholesale price for clients)
    for (const item of items) {
      const product = await prisma.product.findFirst({
        where: { id: item.productId, ...(req.user.companyId ? { companyId: req.user.companyId } : {}) }
      });
      if (!product) {
        return res.status(400).json({ message: `Product ${item.productId} not found in catalog` });
      }
      totalCost += product.wholesalePrice * item.quantity;
    }

    const order = await prisma.salesOrder.create({
      data: {
        clientId: effectiveClientId,
        ...(req.user.companyId ? { companyId: req.user.companyId } : {}),
        status: 'PENDING_REVIEW',
        totalCost,
        shippingAddress: deliveryAddress,
        notes,
        poNumber,
        priority: priority || 'NORMAL',
        items: {
          create: items.map(item => ({
            productId: item.productId,
            quantity: item.quantity
          }))
        }
      },
      include: { items: true }
    });

    await prisma.auditLog.create({
      data: {
        event: 'SALES_ORDER_REQUESTED',
        userId: req.user.role === 'CLIENT' ? null : req.user.id,
        ipAddress: req.ip
      }
    });

    // Notify Warehouse Managers
    await NotificationService.send({
      title: 'New Order Request',
      message: `A new order request (${order.id}) has been placed and is pending review.`,
      ...(req.user.companyId ? { companyId: req.user.companyId } : {})
    });

    res.status(201).json(order);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal server error' });
  }
};
const cancelSalesOrder = async (req, res) => {
  try {
    const { id } = req.params;

    const order = await prisma.salesOrder.findUnique({
      where: { id }
    });

    if (!order) {
      return res.status(404).json({ message: 'Order not found' });
    }

    // Security: ensure the client can only cancel their own orders
    if (req.user.role === 'CLIENT' && order.clientId !== req.user.id) {
      return res.status(403).json({ message: 'Not authorized to cancel this order' });
    }

    if (order.status !== 'PENDING_REVIEW') {
      return res.status(400).json({ message: 'Only pending orders can be canceled' });
    }

    const updatedOrder = await prisma.salesOrder.update({
      where: { id },
      data: {
        status: 'CANCELED',
        rejectionReason: 'Canceled by client',
      }
    });

    await prisma.auditLog.create({
      data: {
        event: 'SALES_ORDER_CANCELED_BY_CLIENT',
        userId: req.user.role === 'CLIENT' ? null : req.user.id,
        ipAddress: req.ip
      }
    });

    res.json(updatedOrder);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

const deleteSalesOrder = async (req, res) => {
  try {
    const { id } = req.params;

    const order = await prisma.salesOrder.findUnique({
      where: { id }
    });

    if (!order) {
      return res.status(404).json({ message: 'Order not found' });
    }

    // Security: ensure the client can only delete their own orders
    if (req.user.role === 'CLIENT' && order.clientId !== req.user.id) {
      return res.status(403).json({ message: 'Not authorized to delete this order' });
    }

    if (order.status !== 'CANCELED' && order.status !== 'REJECTED') {
      return res.status(400).json({ message: 'Only canceled or rejected orders can be deleted' });
    }

    await prisma.salesOrder.delete({
      where: { id }
    });

    await prisma.auditLog.create({
      data: {
        event: 'SALES_ORDER_DELETED_BY_CLIENT',
        userId: req.user.role === 'CLIENT' ? null : req.user.id,
        ipAddress: req.ip
      }
    });

    res.json({ message: 'Order deleted successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

module.exports = {
  createSalesOrder,
  getSalesOrders,
  cancelSalesOrder,
  deleteSalesOrder
};
