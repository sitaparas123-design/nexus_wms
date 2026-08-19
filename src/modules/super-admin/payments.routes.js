const express = require('express');
const router = express.Router();
const paymentsController = require('./payments.controller');
const { verifyToken, requireRole } = require('../../middlewares/auth');

// Super Admin route to view all payments
router.get('/', verifyToken, requireRole(['SUPER_ADMIN']), paymentsController.getPayments);

module.exports = router;
