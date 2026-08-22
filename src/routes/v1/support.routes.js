const express = require('express');
const router = express.Router();
const supportController = require('../../controllers/support.controller');
const { requireRole } = require('../../middlewares/auth');

// Tenant routes
router.post('/', requireRole(['ADMIN']), supportController.createTicket);
router.get('/', requireRole(['ADMIN']), supportController.getTenantTickets);
router.get('/:id', requireRole(['ADMIN']), supportController.getTicketDetails);
router.post('/:id/reply', requireRole(['ADMIN']), supportController.replyToTicket);

module.exports = router;
