const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function fixCompany() {
  // Find Alex
  const alex = await prisma.user.findUnique({
    where: { email: 'alex@stitchnexus.com' }
  });

  if (!alex) {
    console.error("Alex not found!");
    return;
  }

  const newCompanyId = alex.companyId;

  // Update Jordan, Casey, Sam
  const result = await prisma.user.updateMany({
    where: {
      email: {
        in: ['jordan@stitchnexus.com', 'casey@stitchnexus.com', 'sam@acmecorp.com']
      }
    },
    data: {
      companyId: newCompanyId
    }
  });

  console.log(`Updated ${result.count} users to company ${newCompanyId}`);
}

fixCompany()
  .then(() => prisma.$disconnect())
  .catch(console.error);
