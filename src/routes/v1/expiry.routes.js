const express = require('express');
const router = express.Router();
const expiryController = require('../../controllers/expiry.controller');
const { verifyToken, requireRole } = require('../../middlewares/auth');

router.use(verifyToken);

router.post('/scan', requireRole(['ADMIN', 'WAREHOUSE_MANAGER', 'INVENTORY_CLERK']), expiryController.scanExpiryAlerts);
router.get('/alerts', expiryController.getExpiryAlerts);
router.patch('/alerts/:id/resolve', requireRole(['ADMIN', 'WAREHOUSE_MANAGER', 'INVENTORY_CLERK']), expiryController.resolveAlert);

module.exports = router;
