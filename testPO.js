const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function run() {
  try {
    const id = '963c0683-4337-4ec1-ad01-03c62decc58c';
    await prisma.$transaction(async (tx) => {
      await tx.purchaseOrderItem.deleteMany({
        where: { purchaseOrderId: id }
      });
      await tx.purchaseOrder.delete({
        where: { id }
      });
    });
    console.log('Success');
  } catch(e) {
    console.error('Error occurred:', e);
  } finally {
    await prisma.$disconnect();
  }
}

run();
