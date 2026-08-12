const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function migrateClients() {
  try {
    const clientUsers = await prisma.user.findMany({
      where: { role: 'CLIENT' }
    });

    console.log(`Found ${clientUsers.length} client users to migrate.`);

    for (const u of clientUsers) {
      await prisma.client.create({
        data: {
          id: u.id, // keep the same ID so relations don't break if any
          name: u.name,
          email: u.email,
          password: u.password,
          status: u.status,
          companyId: u.companyId,
          warehouseId: u.warehouseId,
          // Defaults for required Client fields
          phone: u.phone || 'N/A',
          address: 'N/A',
          tier: 'STANDARD',
          creditLimit: 0,
        }
      });
      console.log(`Created Client record for ${u.email}`);
      
      await prisma.user.delete({
        where: { id: u.id }
      });
      console.log(`Deleted User record for ${u.email}`);
    }

    console.log('Migration complete.');
  } catch (e) {
    console.error(e);
  } finally {
    await prisma.$disconnect();
  }
}

migrateClients();
