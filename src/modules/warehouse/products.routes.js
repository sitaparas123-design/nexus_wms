const express = require('express');
const router = express.Router();
const productsController = require('./products.controller');
const { verifyToken, requireRole } = require('../../middlewares/auth');

router.use(verifyToken); // All endpoints require auth

// Clients can view products, but creating products is for managers/admins
router.get('/', productsController.getProducts);
router.post('/bulk', requireRole(['ADMIN', 'WAREHOUSE_MANAGER']), productsController.createBulkProducts);
router.post('/', requireRole(['ADMIN', 'WAREHOUSE_MANAGER']), productsController.createProduct);
router.put('/:id', requireRole(['ADMIN', 'WAREHOUSE_MANAGER']), productsController.updateProduct);
router.delete('/:id', requireRole(['ADMIN', 'WAREHOUSE_MANAGER']), productsController.deleteProduct);

module.exports = router;
