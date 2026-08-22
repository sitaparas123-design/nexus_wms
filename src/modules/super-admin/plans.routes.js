const express = require('express');
const router = express.Router();
const plansController = require('./plans.controller');
const { verifyToken, requireRole } = require('../../middlewares/auth');

router.use(verifyToken, requireRole(['SUPER_ADMIN']));

router.get('/', plansController.getPlans);
router.post('/', plansController.createPlan);
router.put('/:id', plansController.updatePlan);
router.delete('/:id', plansController.deletePlan);

module.exports = router;
