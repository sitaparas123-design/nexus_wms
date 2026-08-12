const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  await prisma.salesOrder.update({
    where: { id: '55cc2353-7025-4668-998f-13099b2dab4c' },
    data: { status: 'PENDING_REVIEW' }
  });
  console.log('Reverted to PENDING_REVIEW');
}

main().finally(() => prisma.$disconnect());
