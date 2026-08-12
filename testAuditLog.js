const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  try {
    await prisma.auditLog.create({
      data: {
        event: 'SALES_ORDER_CANCELED_BY_CLIENT',
        userId: null,
        ipAddress: '127.0.0.1'
      }
    });
    console.log('AuditLog created successfully');
  } catch (err) {
    console.error('AuditLog error:', err);
  }
}

main().finally(() => prisma.$disconnect());
