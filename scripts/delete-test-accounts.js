const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  const emails = ['harshjain04055@gmail.com', 'vibewthnature@gmail.com'];
  
  for (const email of emails) {
    const user = await prisma.user.findFirst({ where: { email } });
    if (user) {
      console.log(`Found user: ${email}`);
      
      // Delete associated audit logs, notifications, etc. if any exist
      // Since it's a new account, we might just need to delete the user.
      // The schema for User doesn't have Cascade delete for its relations.
      
      // Let's delete the user first
      try {
        await prisma.user.delete({ where: { id: user.id } });
        console.log(`Deleted user: ${email}`);
        
        // Now delete the company if it was created during registration
        if (user.companyId) {
          const company = await prisma.company.findFirst({ where: { id: user.companyId } });
          if (company) {
            await prisma.company.delete({ where: { id: company.id } });
            console.log(`Deleted company: ${company.name}`);
          }
        }
      } catch (err) {
        console.error(`Error deleting ${email}:`, err.message);
      }
    } else {
      console.log(`User not found: ${email}`);
    }
  }
}

main()
  .catch(e => console.error(e))
  .finally(async () => {
    await prisma.$disconnect();
  });
