const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function updateEmails() {
  try {
    const users = await prisma.user.findMany({
      where: { email: { contains: '@abc.com' } }
    });
    for (const u of users) {
      if (u.role === 'CLIENT') {
        await prisma.user.update({ where: { id: u.id }, data: { email: 'client_usr@abc.com' } });
      } else if (u.role === 'INVENTORY_CLERK') {
        await prisma.user.update({ where: { id: u.id }, data: { email: 'clrk@abc.com' } });
      } else if (u.role === 'WAREHOUSE_MANAGER') {
        await prisma.user.update({ where: { id: u.id }, data: { email: 'mgr@abc.com' } });
      }
    }
    const clients = await prisma.client.findMany({
      where: { email: { contains: '@abc.com' } }
    });
    for (const c of clients) {
      await prisma.client.update({ where: { id: c.id }, data: { email: 'client_usr@abc.com' } });
    }
    console.log('Successfully updated emails');
  } catch(e) {
    console.error(e);
  } finally {
    await prisma.$disconnect();
  }
}
updateEmails();
