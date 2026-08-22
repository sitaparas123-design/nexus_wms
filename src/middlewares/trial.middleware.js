const prisma = require('../utils/prisma');

const checkTrialStatus = async (req, res, next) => {
  try {
    if (!req.user || !req.user.companyId) {
      return next(); // Skip if no user or super admin
    }

    if (req.user.role === 'SUPER_ADMIN') {
      return next();
    }

    const company = await prisma.company.findUnique({
      where: { id: req.user.originalCompanyId || req.user.companyId },
      select: { plan: true, trialEndDate: true, isActive: true }
    });

    if (!company) {
      return res.status(404).json({ message: 'Company not found' });
    }

    if (!company.isActive) {
      return res.status(403).json({ message: 'Your account is disabled. Please contact support.' });
    }

    // Pass company info to request for downstream use
    req.company = company;

    // Check trial expiry
    if (company.plan === 'TRIAL') {
      const now = new Date();
      const expiry = new Date(company.trialEndDate);
      
      // Allow access if it's before expiry (end of Day 7)
      // If now is past expiry date (Day 8+), block access.
      if (now > expiry) {
        // We only block specific routes. 
        const allowedPaths = ['/plans', '/payments', '/support', '/auth/me', '/dashboard/trial-status', '/super-admin'];
        const isAllowedPath = allowedPaths.some(path => req.originalUrl.includes(path));
        
        if (!isAllowedPath) {
           return res.status(402).json({ 
             message: 'Your 7-Day Free Trial has expired. Please purchase a plan to continue.',
             code: 'TRIAL_EXPIRED'
           });
        }
      }
    }

    next();
  } catch (error) {
    console.error('Trial Status Check Error:', error);
    res.status(500).json({ message: 'Internal server error checking trial status' });
  }
};

module.exports = {
  checkTrialStatus
};
