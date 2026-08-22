const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function check() {
  const users = await prisma.user.findMany({
    include: { company: true },
    where: { email: { in: ['alex@stitchnexus.com', 'jordan@stitchnexus.com', 'casey@stitchnexus.com', 'sam@acmecorp.com'] } }
  });
  console.log(JSON.stringify(users, null, 2));
}

check().then(() => prisma.$disconnect());
