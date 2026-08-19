const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const orders = await prisma.salesOrder.findMany({ select: { id: true, status: true } });
  console.log(orders);
}

main().finally(() => prisma.$disconnect());
