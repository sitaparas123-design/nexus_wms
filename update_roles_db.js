const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const result = await prisma.user.updateMany({
    where: {
      role: 'SUPER_ADMIN'
    },
    data: {
      role: 'ADMIN'
    }
  });
  console.log(`Updated ${result.count} users from SUPER_ADMIN to ADMIN`);
}

main()
  .catch(e => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
