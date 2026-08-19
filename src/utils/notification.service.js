const prisma = require('./prisma');

/**
 * Notification Service Abstraction
 * Currently handles database persistence for in-app notifications.
 * Designed to be extensible for email, SMS, or webhooks without changing the business logic.
 */
class NotificationService {
  /**
   * Sends a notification to a specific user or company.
   * @param {Object} payload 
   * @param {string} payload.title
   * @param {string} payload.message
   * @param {string} [payload.companyId]
   * @param {string} [payload.userId] - Optional. If omitted, implies a broadcast to admins of the company.
   * @param {string[]} [payload.targetRoles] - Optional. Fan-out to all users with these roles.
   */
  static async send(payload) {
    const { title, message, companyId, userId, targetRoles } = payload;

    try {
      if (targetRoles && targetRoles.length > 0) {
        // 1. Fan-out to specific roles (Individual notifications per user)
        let users;
        if (companyId) {
          users = await prisma.user.findMany({
            where: { companyId, role: { in: targetRoles } }
          });
        } else {
          users = await prisma.user.findMany({
            where: { role: { in: targetRoles } }
          });
        }

        if (users.length > 0) {
          const notificationsData = users.map(u => ({
            title,
            message,
            companyId: u.companyId || companyId,
            userId: u.id
          }));
          await prisma.notification.createMany({ data: notificationsData });
        }
        return { message: `Sent to ${users ? users.length : 0} users` };
      } else {
        // 2. Persist to Database (Single user or legacy global broadcast)
        const notification = await prisma.notification.create({
          data: {
            title,
            message,
            companyId,
            userId: userId || null
          }
        });
        
        return notification;
      }
    } catch (error) {
      console.error('Failed to send notification:', error);
      throw new Error('Notification failed');
    }
  }

  /**
   * Internal Policy Engine: Checks and increments the email quota for a company.
   * Basic: 500/mo, Advanced: 3000/mo, Customized: 10000/mo
   */
  static async checkAndIncrementQuota(companyId, count = 1) {
    if (!companyId) return true; // No company = system email (no limit)
    
    try {
      const company = await prisma.company.findUnique({ where: { id: companyId } });
      if (!company) return true;

      // Check if month has rolled over
      const now = new Date();
      let resetDate = company.emailLimitResetDate;
      let currentCount = company.monthlyEmailsSent || 0;

      if (!resetDate || (now.getTime() - resetDate.getTime()) > 30 * 24 * 60 * 60 * 1000) {
        // Reset quota
        resetDate = now;
        currentCount = 0;
      }

      // Determine limit based on plan
      let limit = 500; // Basic
      const plan = (company.plan || '').toLowerCase();
      if (plan === 'advanced') limit = 3000;
      if (plan === 'customized') limit = 10000;
      if (plan === 'trial') limit = 100;

      if (currentCount + count > limit) {
        console.warn(`Email Quota Exceeded for company ${company.name} (${companyId}). Limit: ${limit}. Blocked ${count} emails.`);
        return false;
      }

      // Increment quota
      await prisma.company.update({
        where: { id: companyId },
        data: {
          monthlyEmailsSent: currentCount + count,
          emailLimitResetDate: resetDate
        }
      });
      return true;
    } catch (err) {
      console.error('Error checking email quota:', err);
      return true; // Fail-open to not break app functionality on DB error
    }
  }

  static async sendBrevoEmails(users, title, message, company = null) {
    const brevoApiKey = process.env.BREVO_API_KEY;
    if (!brevoApiKey) return; // Silently skip if no API key

    const validUsers = users.filter(u => u.email);
    if (validUsers.length === 0) return;

    if (company) {
      const canSend = await this.checkAndIncrementQuota(company.id, validUsers.length);
      if (!canSend) return; // Policy Engine blocked sending
    }
    
    for (const user of validUsers) {
      try {
        const emailPayload = {
          sender: { 
            name: process.env.MAIL_FROM_NAME || 'Kiaan Technology Pvt Ltd', 
            email: process.env.MAIL_FROM_EMAIL || 'info@kiaantechnology.com' 
          },
          to: [{ email: user.email, name: user.name || 'User' }],
          subject: title,
          htmlContent: `<html><body style="font-family: Arial, sans-serif; padding: 20px;">
            <h2>${title}</h2>
            <p>${message}</p>
            <br/>
            <hr style="border: 1px solid #eee; margin-top: 20px;" />
            <p style="font-size: 12px; color: #888;">This is an automated notification from Kiaan Technology.</p>
          </body></html>`
        };

        if (company && company.email) {
          emailPayload.replyTo = { email: company.email, name: company.name };
        }

        const response = await fetch('https://api.brevo.com/v3/smtp/email', {
          method: 'POST',
          headers: {
            'accept': 'application/json',
            'api-key': brevoApiKey,
            'content-type': 'application/json'
          },
          body: JSON.stringify(emailPayload)
        });

        if (!response.ok) {
          const errorData = await response.text();
          console.error(`Brevo API Error for ${user.email}:`, errorData);
        }
      } catch (err) {
        console.error(`Failed to send email to ${user.email} via Brevo:`, err.message);
      }
    }
  }
  static async sendActivationEmail(user, company, plainPassword) {
    const brevoApiKey = process.env.BREVO_API_KEY;
    if (!brevoApiKey) return;

    // Policy Engine Check
    const canSend = await this.checkAndIncrementQuota(company.id, 1);
    if (!canSend) return;

    const startDate = new Date(company.trialStartDate || new Date()).toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
    let expiryDateObj = new Date(company.trialEndDate || new Date(Date.now() + 7 * 24 * 60 * 60 * 1000));
    
    let price = '₹0.00';
    let duration = '7 Days';
    let expiryText = '7 Days';

    if (company.plan && company.plan.toUpperCase() !== 'TRIAL') {
      // Map plan to price (can be extended if price is saved in DB)
      if (company.plan.toLowerCase() === 'basic') price = '₹799.00';
      else if (company.plan.toLowerCase() === 'advanced') price = '₹1499.00';
      else if (company.plan.toLowerCase() === 'customized') price = 'Custom Pricing';
      else price = 'Paid';
      
      duration = 'Monthly';
      expiryText = expiryDateObj.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
    }

    const htmlContent = `
    <div style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; max-width: 600px; margin: 0 auto; background-color: #1a1a1a; color: #f5f5f5; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
      <div style="background: linear-gradient(135deg, #6366f1, #a855f7); padding: 40px 30px;">
        <div style="font-size: 11px; font-weight: bold; letter-spacing: 1.5px; color: rgba(255,255,255,0.9); text-transform: uppercase; margin-bottom: 15px;">
          Official SaaS Activation Notification
        </div>
        <div style="font-size: 26px; font-weight: bold; color: #ffffff; line-height: 1.3;">
          Welcome to Nexus WMS -<br/>Your Account is Ready
        </div>
      </div>
      
      <div style="padding: 40px 30px;">
        <p style="font-size: 15px; margin-bottom: 20px;">Hello <strong>${user.name}</strong>,</p>
        <p style="font-size: 15px; margin-bottom: 20px; line-height: 1.6; color: #d4d4d4;">
          Welcome to <strong style="color: #ffffff;">Nexus WMS</strong> (Warehouse Management ERP).<br/><br/>
          Your account and plan subscription have been successfully activated.
        </p>

        <h3 style="font-size: 16px; font-weight: bold; color: #ffffff; margin-top: 35px; border-bottom: 1px solid #333; padding-bottom: 8px;">Account Details:</h3>
        <table style="width: 100%; font-size: 14px; line-height: 1.8; margin-bottom: 20px;">
          <tr><td style="color: #a3a3a3; width: 140px;">Name:</td><td style="color: #ffffff; font-weight: 500;">${user.name}</td></tr>
          <tr><td style="color: #a3a3a3;">Email / Login ID:</td><td><a href="mailto:${user.email}" style="color: #60a5fa; text-decoration: none;">${user.email}</a></td></tr>
          <tr><td style="color: #a3a3a3;">Password:</td><td style="color: #ffffff; font-family: monospace; font-size: 15px;">${plainPassword}</td></tr>
          <tr><td style="color: #a3a3a3;">Software:</td><td style="color: #ffffff;">Nexus WMS Warehouse ERP</td></tr>
        </table>

        <h3 style="font-size: 16px; font-weight: bold; color: #ffffff; margin-top: 35px; border-bottom: 1px solid #333; padding-bottom: 8px;">Plan Details:</h3>
        <table style="width: 100%; font-size: 14px; line-height: 1.8;">
          <tr><td style="color: #a3a3a3; width: 140px;">Plan:</td><td style="color: #ffffff; font-weight: 500; text-transform: capitalize;">${company.plan}</td></tr>
          <tr><td style="color: #a3a3a3;">Price:</td><td style="color: #ffffff;">${price}</td></tr>
          <tr><td style="color: #a3a3a3;">Duration:</td><td style="color: #ffffff;">${duration}</td></tr>
          <tr><td style="color: #a3a3a3;">Start Date:</td><td style="color: #ffffff;">${startDate}</td></tr>
          <tr><td style="color: #a3a3a3;">Expiry Date:</td><td style="color: #ffffff;">${expiryText}</td></tr>
        </table>

        <div style="margin-top: 40px; padding: 25px; background-color: #262626; border-radius: 12px; border: 1px solid #404040; text-align: center;">
          <h4 style="margin: 0 0 15px 0; color: #ffffff; font-size: 15px;">Included Features in Nexus WMS Portal:</h4>
          <p style="margin: 0; color: #d4d4d4; font-size: 13px; line-height: 1.8;">
            ✨ Real-time Inventory & Order Tracking<br/>
            ✨ Multi-Warehouse Support & AI Analytics<br/>
            ✨ Advanced Role-based Access Control
          </p>
        </div>
      </div>
    </div>
    `;

    try {
      const emailPayload = {
        sender: { 
          name: process.env.MAIL_FROM_NAME || 'Kiaan Technology Pvt Ltd', 
          email: process.env.MAIL_FROM_EMAIL || 'info@kiaantechnology.com' 
        },
        to: [{ email: user.email, name: user.name }],
        subject: 'Welcome to Nexus WMS - Account Activated',
        htmlContent
      };

      if (company && company.email) {
        emailPayload.replyTo = { email: company.email, name: company.name };
      }

      const response = await fetch('https://api.brevo.com/v3/smtp/email', {
        method: 'POST',
        headers: {
          'accept': 'application/json',
          'api-key': brevoApiKey,
          'content-type': 'application/json'
        },
        body: JSON.stringify(emailPayload)
      });

      if (!response.ok) {
        const errorData = await response.text();
        console.error('Brevo API Error for Activation Email:', errorData);
      }
    } catch (err) {
      console.error('Failed to send activation email via Brevo:', err.message);
    }
  }
}

module.exports = NotificationService;
