const { PrismaClient } = require('@prisma/client');
const bcrypt = require('bcrypt');
const prisma = new PrismaClient();

async function createAdmin() {
  try {
    const admin = await prisma.user.findFirst({ where: { role: 'SUPER_ADMIN' } });
    if (!admin) {
      const hashedPassword = await bcrypt.hash('123456', 10);
      await prisma.user.create({
        data: {
          name: 'Super Admin',
          email: 'alex@stitchnexus.com',
          password: hashedPassword,
          role: 'SUPER_ADMIN',
          status: 'ACTIVE'
        }
      });
      console.log('Super Admin created');
    } else {
      console.log('Super Admin already exists');
    }
  } catch(e) {
    console.error(e);
  } finally {
    await prisma.$disconnect();
  }
}
createAdmin();
