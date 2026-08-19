const express = require('express');
const router = express.Router();
const supportController = require('./support.controller');
const { verifyToken, requireRole } = require('../../middlewares/auth');

router.use(verifyToken);
router.use(requireRole(['SUPER_ADMIN']));

router.get('/', supportController.getAllTickets);
router.get('/:id', supportController.getTicketDetails);
router.post('/:id/reply', supportController.replyToTicket);
router.put('/:id/status', supportController.updateTicketStatus);

module.exports = router;
