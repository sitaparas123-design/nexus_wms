const prisma = require('../../utils/prisma');

const getDashboardStats = async (req, res) => {
  try {
    const today = new Date();
    const startOfMonth = new Date(today.getFullYear(), today.getMonth(), 1);
    const next30Days = new Date();
    next30Days.setDate(today.getDate() + 30);

    // Real counts
    const totalAdmins = await prisma.company.count();
    const activeAdmins = await prisma.company.count({ where: { isActive: true } });

    // Plan breakdown
    const companies = await prisma.company.findMany({
      select: {
        id: true,
        name: true,
        plan: true,
        trialEndDate: true,
        trialStartDate: true,
        isActive: true,
        status: true,
        email: true,
        phone: true,
      }
    });

    let freeTrialAdmins = 0;
    let expiredTrials = 0;
    let activePaidPlans = 0;
    let expiredPaidPlans = 0;
    let upcomingRenewalsCount = 0;
    const upcomingRenewalsList = [];

    companies.forEach(company => {
      const isExpired = company.trialEndDate && new Date(company.trialEndDate) < today;
      const isUpcoming = company.trialEndDate &&
        new Date(company.trialEndDate) >= today &&
        new Date(company.trialEndDate) <= next30Days;

      if (company.plan === 'TRIAL') {
        if (isExpired) expiredTrials++;
        else freeTrialAdmins++;
      } else {
        if (!company.isActive) expiredPaidPlans++;
        else activePaidPlans++;
      }

      if (isUpcoming) {
        upcomingRenewalsCount++;
        upcomingRenewalsList.push({
          id: company.id,
          name: company.name,
          email: company.email,
          phone: company.phone,
          plan: company.plan,
          trialEndDate: company.trialEndDate,
          isActive: company.isActive,
          status: company.status,
        });
      }
    });

    // Real revenue from successful payments
    const allPayments = await prisma.payment.findMany({
      where: { status: 'SUCCESS' },
      select: { amount: true, paymentDate: true }
    });

    let totalRevenue = 0;
    let monthlyRevenue = 0;

    allPayments.forEach(payment => {
      totalRevenue += payment.amount;
      const pDate = new Date(payment.paymentDate);
      if (
        pDate >= startOfMonth &&
        pDate.getFullYear() === today.getFullYear()
      ) {
        monthlyRevenue += payment.amount;
      }
    });

    // New companies this month
    const newThisMonth = await prisma.company.count({
      where: { createdAt: { gte: startOfMonth } }
    });

    const openSupportTickets = await prisma.supportTicket.count({
      where: { status: 'OPEN' }
    });

    res.json({
      totalAdmins,
      activeAdmins,
      freeTrialAdmins,
      expiredTrials,
      activePaidPlans,
      expiredPaidPlans,
      totalRevenue,
      monthlyRevenue,
      upcomingRenewalsCount,
      upcomingRenewalsList,
      newThisMonth,
      openSupportTickets,
    });
  } catch (error) {
    console.error('Super Admin Dashboard Stats Error:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

module.exports = { getDashboardStats };
