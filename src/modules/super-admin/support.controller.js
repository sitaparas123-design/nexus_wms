const prisma = require('../../utils/prisma');

const getAllTickets = async (req, res) => {
  try {
    const tickets = await prisma.supportTicket.findMany({
      include: {
        company: {
          select: { name: true }
        },
        user: {
          select: { name: true, email: true }
        }
      },
      orderBy: { updatedAt: 'desc' }
    });

    res.json(tickets);
  } catch (error) {
    console.error('Fetch Support Tickets Error:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

const getTicketDetails = async (req, res) => {
  try {
    const { id } = req.params;
    const ticket = await prisma.supportTicket.findUnique({
      where: { id },
      include: {
        company: {
          select: { name: true }
        },
        user: {
          select: { name: true, email: true }
        },
        messages: {
          orderBy: { createdAt: 'asc' }
        }
      }
    });

    if (!ticket) return res.status(404).json({ message: 'Ticket not found' });

    res.json(ticket);
  } catch (error) {
    console.error('Fetch Support Ticket Details Error:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

const replyToTicket = async (req, res) => {
  try {
    const { id } = req.params;
    const { message } = req.body;

    if (!message) return res.status(400).json({ message: 'Message is required' });

    // Transaction to add message and update ticket status
    const result = await prisma.$transaction(async (tx) => {
      const newMessage = await tx.ticketMessage.create({
        data: {
          ticketId: id,
          senderRole: 'SUPER_ADMIN',
          message
        }
      });

      const updatedTicket = await tx.supportTicket.update({
        where: { id },
        data: { status: 'REPLIED' }
      });

      return { newMessage, updatedTicket };
    });

    res.json(result);
  } catch (error) {
    console.error('Reply to Support Ticket Error:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

const updateTicketStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;

    if (!['OPEN', 'REPLIED', 'CLOSED'].includes(status)) {
      return res.status(400).json({ message: 'Invalid status' });
    }

    const updatedTicket = await prisma.supportTicket.update({
      where: { id },
      data: { status }
    });

    res.json(updatedTicket);
  } catch (error) {
    console.error('Update Support Ticket Status Error:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

module.exports = {
  getAllTickets,
  getTicketDetails,
  replyToTicket,
  updateTicketStatus
};
