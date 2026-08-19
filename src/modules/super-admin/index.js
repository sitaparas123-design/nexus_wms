const express = require('express');
const router = express.Router();

const authRoutes = require('./auth.routes');
const usersRoutes = require('./users.routes');
const companiesRoutes = require('./companies.routes');
const clientsRoutes = require('./clients.routes');
const auditLogsRoutes = require('./audit-logs.routes');
const rolesRoutes = require('./roles.routes');
const dashboardRoutes = require('./dashboard.routes');
const plansRoutes = require('./plans.routes');
const paymentsRoutes = require('./payments.routes');
const supportRoutes = require('./support.routes');

router.use('/auth', authRoutes);
router.use('/users', usersRoutes);
router.use('/companies', companiesRoutes);
router.use('/clients', clientsRoutes);
router.use('/audit-logs', auditLogsRoutes);
router.use('/roles', rolesRoutes);
router.use('/super-admin/dashboard', dashboardRoutes);
router.use('/super-admin/plans', plansRoutes);
router.use('/super-admin/payments', paymentsRoutes);
router.use('/super-admin/support', supportRoutes);

module.exports = router;
