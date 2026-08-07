const express = require('express');
const router = express.Router();
const { verifyToken, requireRole } = require('../../middlewares/auth');

const allowedRoles = ['SUPER_ADMIN', 'WAREHOUSE_MANAGER', 'INVENTORY_CLERK', 'CLIENT'];

/**
 * GET /invoices
 * Returns all invoices for the current company.
 * CLIENT role: only their own invoices.
 */
router.get('/invoices', verifyToken, requireRole(allowedRoles), async (req, res) => {
  try {
    const prisma = require('../../utils/prisma');
    const { role, companyId, id: userId } = req.user;

    // Try to find invoices table — gracefully handle if it doesn't exist yet
    if (!prisma.invoice) {
      return res.json({ items: [], total: 0, message: 'Invoice module coming soon' });
    }

    const where = {};
    if (companyId) where.companyId = companyId;
    if (role === 'CLIENT') where.clientId = userId;

    const invoices = await prisma.invoice.findMany({
      where,
      include: {
        salesOrder: { select: { orderNumber: true } },
        client: { select: { name: true, email: true } },
        company: { select: { name: true } }
      },
      orderBy: { createdAt: 'desc' },
    });

    res.json({ items: invoices, total: invoices.length });
  } catch (error) {
    // If invoice model doesn't exist in schema yet, return empty
    if (error.code === 'P2021' || error.message?.includes('does not exist')) {
      return res.json({ items: [], total: 0 });
    }
    console.error('Invoices fetch error:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
});

module.exports = router;
