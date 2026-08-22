const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  await prisma.user.updateMany({
    where: { role: 'SUPER_ADMIN' },
    data: { email: 'kiaan@gmail.com' }
  });
  console.log('UPDATED EMAIL TO kiaan@gmail.com');
}
main().finally(() => prisma.$disconnect());
