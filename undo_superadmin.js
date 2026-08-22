const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const result = await prisma.user.deleteMany({
    where: { role: 'SUPER_ADMIN' }
  });
  console.log(`DELETED ${result.count} SUPER_ADMIN user(s) from the live DB.`);
}
main().finally(() => prisma.$disconnect());
