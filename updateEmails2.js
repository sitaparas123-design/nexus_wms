const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function updateEmails() {
  try {
    const users = await prisma.user.findMany();
    for (const u of users) {
      if (u.role === 'CLIENT') {
        await prisma.user.update({ where: { id: u.id }, data: { email: 'stitchclient@gmail.com' } });
      } else if (u.role === 'INVENTORY_CLERK') {
        await prisma.user.update({ where: { id: u.id }, data: { email: 'stitchclerk@gmail.com' } });
      } else if (u.role === 'WAREHOUSE_MANAGER') {
        await prisma.user.update({ where: { id: u.id }, data: { email: 'stitchmanager@gmail.com' } });
      }
    }
    
    // Just in case there are clients in the client table
    const clients = await prisma.client.findMany();
    for (const c of clients) {
      await prisma.client.update({ where: { id: c.id }, data: { email: 'stitchclient@gmail.com' } });
    }
    
    console.log('Emails updated successfully');
  } catch (e) {
    console.error(e);
  } finally {
    await prisma.$disconnect();
  }
}
updateEmails();
