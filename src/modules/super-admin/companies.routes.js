const express = require('express');
const router = express.Router();
const companiesController = require('./companies.controller');
const { verifyToken, requireRole } = require('../../middlewares/auth');

router.use(verifyToken, requireRole(['SUPER_ADMIN']));

router.get('/', companiesController.getCompanies);
router.post('/', companiesController.createCompany);
router.put('/:id', companiesController.updateCompany);
router.delete('/:id', companiesController.deleteCompany);
router.put('/:id/status', companiesController.toggleCompanyStatus);
router.put('/:id/extend-trial', companiesController.extendTrial);
router.post('/:id/reset-password', companiesController.resetAdminPassword);

module.exports = router;
