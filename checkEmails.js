const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function checkEmails() {
  try {
    const users = await prisma.user.findMany({
      select: { id: true, email: true, role: true }
    });
    console.log('--- Users ---');
    console.table(users);

    const clients = await prisma.client.findMany({
      select: { id: true, email: true }
    });
    console.log('--- Clients ---');
    console.table(clients);
  } catch(e) {
    console.error(e);
  } finally {
    await prisma.$disconnect();
  }
}
checkEmails();
