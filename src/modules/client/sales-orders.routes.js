const express = require('express');
const router = express.Router();
const salesOrdersController = require('./sales-orders.controller');
const { verifyToken, requireRole } = require('../../middlewares/auth');

// Allow both CLIENTs to view/create, and internal staff to view if they use client portal
router.use(verifyToken, requireRole(['CLIENT', 'ADMIN', 'WAREHOUSE_MANAGER']));

router.get('/sales-orders', salesOrdersController.getSalesOrders);
router.post('/sales-orders', salesOrdersController.createSalesOrder);
router.put('/sales-orders/:id/cancel', salesOrdersController.cancelSalesOrder);
router.delete('/sales-orders/:id', salesOrdersController.deleteSalesOrder);

module.exports = router;
