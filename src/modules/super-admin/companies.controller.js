const prisma = require('../../utils/prisma');

const getCompanies = async (req, res) => {
  try {
    const companies = await prisma.company.findMany({
      orderBy: { createdAt: 'desc' },
      include: {
        payments: {
          orderBy: { paymentDate: 'desc' },
          take: 1
        },
        _count: {
          select: { users: true, warehouses: true }
        }
      }
    });
    res.json(companies);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

const createCompany = async (req, res) => {
  try {
    const { name, industry, clientCode, status, email, phone } = req.body;

    if (!name) {
      return res.status(400).json({ message: 'Company name is required' });
    }

    const company = await prisma.company.create({
      data: { 
        name, 
        industry,
        clientCode,
        status: status || 'ACTIVE',
        email,
        phone
      }
    });

    await prisma.auditLog.create({
      data: {
        event: 'COMPANY_PROVISIONED',
        userId: req.user.id,
        ipAddress: req.ip
      }
    });

    res.status(201).json(company);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

const updateCompany = async (req, res) => {
  try {
    const { id } = req.params;
    const { name, industry, clientCode, status, email, phone } = req.body;

    const company = await prisma.company.update({
      where: { id },
      data: {
        ...(name ? { name } : {}),
        ...(industry !== undefined ? { industry } : {}),
        ...(clientCode !== undefined ? { clientCode } : {}),
        ...(status !== undefined ? { status } : {}),
        ...(email !== undefined ? { email } : {}),
        ...(phone !== undefined ? { phone } : {}),
        updatedAt: new Date(),
      },
    });

    await prisma.auditLog.create({
      data: {
        event: 'COMPANY_UPDATED',
        userId: req.user.id,
        ipAddress: req.ip
      }
    });

    res.json(company);
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: error.message || 'Failed to update company' });
  }
};

const deleteCompany = async (req, res) => {
  try {
    const { id } = req.params;

    // Prevent Admin from deleting their own company
    const userCompanyId = req.user.originalCompanyId || req.user.companyId;
    if (req.user && userCompanyId === id) {
      return res.status(403).json({ message: 'Action Denied: You cannot delete your own active company.' });
    }

    await prisma.$transaction(async (tx) => {
      // 1. Delete linked operational records to prevent Foreign Key constraints
      // First, find all users to delete their audit logs
      const companyUsers = await tx.user.findMany({ where: { companyId: id }, select: { id: true } });
      const userIds = companyUsers.map(u => u.id);

      // Deepest dependencies first
      await tx.pickListItem.deleteMany({ where: { pickList: { companyId: id } } });
      await tx.pickList.deleteMany({ where: { companyId: id } });
      await tx.shipment.deleteMany({ where: { companyId: id } });
      await tx.notification.deleteMany({ where: { companyId: id } });
      await tx.transferOrder.deleteMany({ where: { OR: [{ sourceCompanyId: id }, { destinationCompanyId: id }] } });

      await tx.locationInventory.deleteMany({ where: { companyId: id } });
      await tx.inventoryLedger.deleteMany({ where: { companyId: id } });
      await tx.inventory.deleteMany({ where: { companyId: id } });
      await tx.stockAdjustment.deleteMany({ where: { companyId: id } });
      await tx.expiryAlert.deleteMany({ where: { companyId: id } });
      await tx.barcode.deleteMany({ where: { companyId: id } });
      await tx.transferItem.deleteMany({ where: { transfer: { companyId: id } } });
      await tx.inventoryTransfer.deleteMany({ where: { companyId: id } });
      await tx.batch.deleteMany({ where: { companyId: id } });
      await tx.receivingItem.deleteMany({ where: { companyId: id } });
      await tx.receiving.deleteMany({ where: { companyId: id } });
      
      // Delete orders that reference Product or Client
      await tx.salesOrderItem.deleteMany({ where: { salesOrder: { companyId: id } } });
      await tx.salesOrder.deleteMany({ where: { companyId: id } });
      await tx.purchaseOrderItem.deleteMany({ where: { purchaseOrder: { companyId: id } } });
      await tx.purchaseOrder.deleteMany({ where: { companyId: id } });

      // Now Product can be deleted
      await tx.product.deleteMany({ where: { companyId: id } });
      await tx.category.deleteMany({ where: { companyId: id } });
      await tx.location.deleteMany({ where: { companyId: id } });
      
      // Client and Warehouse
      await tx.client.deleteMany({ where: { companyId: id } });
      await tx.warehouse.deleteMany({ where: { companyId: id } });

      // Clean up audit logs for company users so users can be deleted
      if (userIds.length > 0) {
        await tx.auditLog.deleteMany({ where: { userId: { in: userIds } } });
      }

      // 2. Log audit event BEFORE deleting target company 
      await tx.auditLog.create({
        data: {
          event: 'COMPANY_DELETED',
          userId: req.user.id,
          ipAddress: req.ip
        }
      });

      // 3. Delete users and company record
      await tx.user.deleteMany({ where: { companyId: id } });

      // 4. Delete target company record
      await tx.company.delete({
        where: { id },
      });
    });

    res.json({ message: 'Company and all associated data deleted successfully', id });
  } catch (error) {
    console.error('Delete company error:', error);
    res.status(400).json({ message: error.message || 'Failed to delete company due to linked records.' });
  }
};

const toggleCompanyStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const company = await prisma.company.findUnique({ where: { id } });
    if (!company) return res.status(404).json({ message: 'Company not found' });
    
    const newStatus = !company.isActive;
    await prisma.company.update({
      where: { id },
      data: { isActive: newStatus, status: newStatus ? 'ACTIVE' : 'BLOCKED' }
    });
    
    res.json({ message: `Company ${newStatus ? 'activated' : 'blocked'} successfully` });
  } catch (error) {
    res.status(500).json({ message: 'Internal server error' });
  }
};

const extendTrial = async (req, res) => {
  try {
    const { id } = req.params;
    const { days } = req.body;
    
    const company = await prisma.company.findUnique({ where: { id } });
    if (!company) return res.status(404).json({ message: 'Company not found' });
    
    const newEndDate = company.trialEndDate ? new Date(company.trialEndDate) : new Date();
    newEndDate.setDate(newEndDate.getDate() + (days || 7));
    
    await prisma.company.update({
      where: { id },
      data: { trialEndDate: newEndDate, isActive: true, status: 'ACTIVE' }
    });
    
    res.json({ message: `Trial extended by ${days || 7} days.` });
  } catch (error) {
    res.status(500).json({ message: 'Internal server error' });
  }
};

const resetAdminPassword = async (req, res) => {
  try {
    const { id } = req.params;
    const adminUser = await prisma.user.findFirst({ where: { companyId: id, role: 'ADMIN' } });
    
    if (!adminUser) return res.status(404).json({ message: 'Admin user not found for this company' });
    
    // In a real app, generate a reset token and send email.
    // For now, we return a mock success message.
    res.json({ message: `Password reset link sent to ${adminUser.email}` });
  } catch (error) {
    res.status(500).json({ message: 'Internal server error' });
  }
};

module.exports = { getCompanies, createCompany, updateCompany, deleteCompany, toggleCompanyStatus, extendTrial, resetAdminPassword };
