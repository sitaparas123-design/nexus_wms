const prisma = require('../utils/prisma');

exports.createTicket = async (req, res) => {
  try {
    const { subject, description } = req.body;
    const companyId = req.user.companyId || req.user.originalCompanyId;

    if (!subject || !description) {
      return res.status(400).json({ message: 'Subject and description are required' });
    }

    const ticket = await prisma.supportTicket.create({
      data: {
        title: subject,
        description,
        companyId,
        userId: req.user.id
      }
    });

    res.status(201).json({ message: 'Support ticket created successfully', ticket });
  } catch (error) {
    console.error('Create Ticket Error:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

exports.getTenantTickets = async (req, res) => {
  try {
    const companyId = req.user.companyId || req.user.originalCompanyId;
    
    const tickets = await prisma.supportTicket.findMany({
      where: { companyId },
      orderBy: { createdAt: 'desc' }
    });

    res.json(tickets);
  } catch (error) {
    console.error('Get Tenant Tickets Error:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

exports.getTicketDetails = async (req, res) => {
  try {
    const { id } = req.params;
    const companyId = req.user.companyId || req.user.originalCompanyId;

    const ticket = await prisma.supportTicket.findFirst({
      where: { id, companyId },
      include: {
        messages: {
          orderBy: { createdAt: 'asc' }
        }
      }
    });

    if (!ticket) return res.status(404).json({ message: 'Ticket not found' });

    res.json(ticket);
  } catch (error) {
    console.error('Get Ticket Details Error:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

exports.replyToTicket = async (req, res) => {
  try {
    const { id } = req.params;
    const { message } = req.body;
    const companyId = req.user.companyId || req.user.originalCompanyId;

    if (!message) return res.status(400).json({ message: 'Message is required' });

    const ticket = await prisma.supportTicket.findFirst({ where: { id, companyId } });
    if (!ticket) return res.status(404).json({ message: 'Ticket not found' });

    const result = await prisma.$transaction(async (tx) => {
      const newMessage = await tx.ticketMessage.create({
        data: {
          ticketId: id,
          senderId: req.user.id,
          senderRole: 'ADMIN',
          message
        }
      });

      const updatedTicket = await tx.supportTicket.update({
        where: { id },
        data: { status: 'OPEN' }
      });

      return { newMessage, updatedTicket };
    });

    res.json(result);
  } catch (error) {
    console.error('Reply to Support Ticket Error:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};
