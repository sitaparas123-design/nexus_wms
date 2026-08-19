const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function linkAdminToCompany() {
  try {
    const stitchNexus = await prisma.company.findFirst({
      where: { name: { contains: 'StitchNexus' } }
    });
    
    if (stitchNexus) {
      const admin = await prisma.user.findFirst({
        where: { role: 'SUPER_ADMIN' }
      });
      
      if (admin) {
        await prisma.user.update({
          where: { id: admin.id },
          data: { companyId: stitchNexus.id }
        });
        console.log(`Updated SUPER_ADMIN to company ${stitchNexus.id}`);
      } else {
        console.log('No SUPER_ADMIN found');
      }
    } else {
      console.log('No StitchNexus company found');
    }
  } catch (e) {
    console.error(e);
  } finally {
    await prisma.$disconnect();
  }
}
linkAdminToCompany();
