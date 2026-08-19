const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  // To avoid foreign key constraint errors with payments, we might need to delete payments first or just use upsert.
  // We can use upsert to create or update the exact plans we need.
  
  const plansToSeed = [
    { id: 'basic', name: 'Basic', price: 799.0, durationDays: 30 },
    { id: 'advanced', name: 'Advanced', price: 1499.0, durationDays: 30 },
    { id: 'customized', name: 'Customized', price: 1.0, durationDays: 30 } // 1.0 to avoid Razorpay 0 limit
  ];

  for (const p of plansToSeed) {
    await prisma.plan.upsert({
      where: { id: p.id },
      update: { name: p.name, price: p.price, durationDays: p.durationDays },
      create: p
    });
    console.log(`Upserted plan: ${p.name}`);
  }
}

main()
  .catch(e => console.error(e))
  .finally(async () => {
    await prisma.$disconnect();
  });
