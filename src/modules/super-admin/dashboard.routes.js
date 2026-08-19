const express = require('express');
const router = express.Router();
const dashboardController = require('./dashboard.controller');
const { verifyToken, requireRole } = require('../../middlewares/auth');

router.use(verifyToken, requireRole(['SUPER_ADMIN']));

router.get('/', dashboardController.getDashboardStats);

module.exports = router;
