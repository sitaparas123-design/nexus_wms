const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function run() {
  const c = await prisma.client.findMany();
  console.log(c);
  await prisma.$disconnect();
}
run();
