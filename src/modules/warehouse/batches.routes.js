const express = require('express');
const router = express.Router();
const batchesController = require('./batches.controller');
const { verifyToken, requireRole } = require('../../middlewares/auth');

router.use(verifyToken);

router.get('/', requireRole(['ADMIN', 'WAREHOUSE_MANAGER', 'INVENTORY_CLERK', 'CLIENT']), batchesController.getBatches);
router.post('/', requireRole(['ADMIN', 'WAREHOUSE_MANAGER', 'INVENTORY_CLERK']), batchesController.createBatch);
router.put('/:id', requireRole(['ADMIN', 'WAREHOUSE_MANAGER', 'INVENTORY_CLERK']), batchesController.updateBatch);
router.post('/:id/unlock-coa', requireRole(['ADMIN', 'WAREHOUSE_MANAGER', 'INVENTORY_CLERK', 'CLIENT']), batchesController.unlockCoa);
router.delete('/:id', requireRole(['ADMIN']), batchesController.deleteBatch);

module.exports = router;
