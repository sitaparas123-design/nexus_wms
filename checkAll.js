const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function checkAll() {
  const u = await prisma.user.findMany({ select: { email: true, role: true } });
  console.table(u);
  await prisma.$disconnect();
}
checkAll();
