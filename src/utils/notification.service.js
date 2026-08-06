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
}

module.exports = NotificationService;
