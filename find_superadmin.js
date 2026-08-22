const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const user = await prisma.user.findFirst({ where: { role: 'SUPER_ADMIN' } });
  if (user) {
    console.log('SUPER_ADMIN EMAIL: ' + user.email);
  } else {
    console.log('NO SUPER ADMIN FOUND');
    // Seed one
    const bcrypt = require('bcrypt');
    const hash = await bcrypt.hash('123456', 10);
    const newAdmin = await prisma.user.create({
      data: {
        email: 'owner@stitchnexus.com',
        password: hash,
        name: 'Platform Owner',
        role: 'SUPER_ADMIN'
      }
    });
    console.log('CREATED SUPER ADMIN: ' + newAdmin.email);
  }
}
main().finally(() => prisma.$disconnect());
