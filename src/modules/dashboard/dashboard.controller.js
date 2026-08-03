const prisma = require('../../utils/prisma');

// SUPER_ADMIN Dashboard
exports.getSuperAdminDashboard = async (req, res) => {
  try {
    const activeCompanies = await prisma.company.count();

    const products = await prisma.product.findMany({
      select: { availableStock: true, unitCost: true }
    });
    
    const globalInventoryValue = products.reduce((acc, prod) => {
      const val = (prod.availableStock || 0) * (prod.unitCost || 0);
      return acc + val;
    }, 0);

    const monthlyRevenue = 45000;
    const systemUptime = "99.98%";

    const auditLogs = await prisma.auditLog.findMany({
      take: 10,
      orderBy: { timestamp: 'desc' },
      include: {
        user: { select: { id: true, name: true, email: true, role: true } }
      }
    });

    const companiesList = await prisma.company.findMany({
      include: {
        _count: { select: { salesOrders: true, users: true } }
      },
      orderBy: { createdAt: 'desc' },
      take: 10
    });

    res.json({
      activeCompanies,
      globalInventoryValue,
      monthlyRevenue,
      systemUptime,
      auditLogs,
      companiesList
    });
  } catch (error) {
    console.error('Super Admin Dashboard Error:', error);
    res.status(500).json({ error: error.message || 'Failed to fetch super admin dashboard data.' });
  }
};

// WAREHOUSE_MANAGER Dashboard
exports.getManagerDashboard = async (req, res) => {
  try {
    const companyId = req.user?.companyId;
    const whereCompany = companyId ? { companyId } : {};

    // 1. Pending Sales Orders
    const pendingSalesOrders = await prisma.salesOrder.count({
      where: {
        ...whereCompany,
        status: { in: ['PENDING_REVIEW', 'PENDING_APPROVAL', 'PICKING', 'PACKING', 'PENDING'] },
      },
    });

    // 2. Pending Pick Tasks
    const pendingPickLists = await prisma.salesOrder.count({
      where: {
        ...whereCompany,
        status: { in: ['PICKING', 'PENDING'] },
      },
    });

    // 3. Near Expiry Batches (< 30 days)
    const thirtyDaysFromNow = new Date();
    thirtyDaysFromNow.setDate(thirtyDaysFromNow.getDate() + 30);

    const nearExpiryBatches = await prisma.batch.findMany({
      where: {
        ...whereCompany,
        quarantine: false,
        expiryDate: { lte: thirtyDaysFromNow },
      },
      include: { product: true },
      orderBy: { expiryDate: 'asc' },
      take: 10,
    });

    const nearExpiryCount = nearExpiryBatches.length;

    // 4. Recent Shipments
    const recentShipments = await prisma.salesOrder.findMany({
      where: {
        ...whereCompany,
        status: 'SHIPPED',
      },
      include: { client: true },
      orderBy: { updatedAt: 'desc' },
      take: 5,
    });
    const todaysShipments = recentShipments.length;

    // 5. Incoming Purchase Orders
    const incomingShipments = await prisma.purchaseOrder.findMany({
      where: {
        ...whereCompany,
        status: { in: ['PENDING', 'APPROVED'] }
      },
      take: 5,
      orderBy: { createdAt: 'desc' }
    });

    // 6. Warehouse Capacity
    const activeLocations = await prisma.location.findMany({
      where: { ...whereCompany, deletedAt: null },
      include: { locationInventories: { select: { quantity: true } } }
    });

    let totalMaxCapacity = 0;
    let totalOccupied = 0;

    activeLocations.forEach(loc => {
      totalMaxCapacity += (loc.maxCapacity || 0);
      const locOccupied = loc.locationInventories.reduce((sum, inv) => sum + (inv.quantity || 0), 0);
      totalOccupied += locOccupied;
    });

    let capacityPercentage = 0;
    if (totalMaxCapacity > 0) {
      capacityPercentage = Math.round((totalOccupied / totalMaxCapacity) * 100);
    }

    res.json({
      warehouseCapacity: totalMaxCapacity,
      capacityPercentage,
      pendingTasks: pendingPickLists + pendingSalesOrders,
      pendingPickLists,
      pendingSalesOrders,
      todaysShipments,
      nearExpiryCount,
      expiringLots: nearExpiryBatches,
      nearExpiryBatches,
      incomingShipments,
      recentShipments,
    });
  } catch (error) {
    console.error('Manager Dashboard Error:', error);
    res.status(500).json({ error: error.message || 'Failed to fetch manager dashboard data.' });
  }
};

// INVENTORY_CLERK Dashboard
exports.getClerkDashboard = async (req, res) => {
  try {
    const companyId = req.user?.companyId;
    const whereCompany = companyId ? { companyId } : {};

    const totalSkus = await prisma.product.count({ where: whereCompany });
    
    const products = await prisma.product.findMany({ where: whereCompany });
    const lowStockAlerts = products.filter(p => (p.availableStock || 0) < 10).length;
    const stockAlertsList = products.filter(p => (p.availableStock || 0) < 10).slice(0, 5);

    const barcodesToPrint = await prisma.barcode.count({ where: whereCompany });
    const openCycleCounts = 0;

    const pendingPickLists = await prisma.salesOrder.findMany({
      where: {
        ...whereCompany,
        status: { in: ['PENDING_REVIEW', 'PICKING', 'READY_TO_SHIP'] },
      },
      include: { client: true },
      orderBy: { updatedAt: 'desc' },
      take: 5,
    });

    res.json({
      totalSkus,
      openCycleCounts,
      lowStockAlerts,
      barcodesToPrint,
      taskQueue: pendingPickLists,
      pendingPickLists,
      stockAlertsList
    });
  } catch (error) {
    console.error('Clerk Dashboard Error:', error);
    res.status(500).json({ error: error.message || 'Failed to fetch clerk dashboard data.' });
  }
};

// CLIENT Dashboard
exports.getClientDashboard = async (req, res) => {
  try {
    const companyId = req.user?.companyId;
    const whereCompany = companyId ? { companyId } : {};

    const activeOrders = await prisma.salesOrder.count({
      where: {
        ...whereCompany,
        status: { notIn: ['DELIVERED', 'CANCELLED', 'REJECTED'] }
      }
    });

    const allOrders = await prisma.salesOrder.findMany({
      where: whereCompany,
      include: { items: { include: { product: true } } },
      orderBy: { createdAt: 'desc' }
    });
    
    const totalSpend = allOrders.reduce((acc, order) => acc + (order.totalCost || 0), 0);

    const availableCredits = 25000;
    const coasPending = 0;

    const recentOrders = allOrders.slice(0, 5);
    const mostRecentOrder = allOrders[0] || null;

    res.json({
      activeOrders,
      totalSpend,
      availableCredits,
      coasPending,
      recentOrders,
      mostRecentOrder
    });
  } catch (error) {
    console.error('Client Dashboard Error:', error);
    res.status(500).json({ error: error.message || 'Failed to fetch client dashboard data.' });
  }
};

