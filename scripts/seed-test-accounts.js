const { PrismaClient } = require('@prisma/client');
const bcrypt = require('bcrypt');

const prisma = new PrismaClient();

async function main() {
  const password = await bcrypt.hash('test123', 10);

  // ── 1. Find or create a ₹599 plan ──────────────────────────────────
  let plan599 = await prisma.plan.findFirst({ where: { price: 599 } });
  if (!plan599) {
    plan599 = await prisma.plan.create({
      data: {
        name: 'STARTER',
        price: 599,
        durationDays: 30,
        isActive: true,
        description: 'Starter plan — 30 days full access',
      },
    });
    console.log('✅ Created plan:', plan599.name, '₹', plan599.price);
  } else {
    console.log('✅ Found existing plan:', plan599.name, '₹', plan599.price);
  }

  // ── 2. EXPIRED TRIAL account ────────────────────────────────────────
  const expiredEmail = 'expired.trial@test.com';
  const existingExpired = await prisma.user.findFirst({ where: { email: expiredEmail } });

  if (!existingExpired) {
    const expiredCompany = await prisma.company.create({
      data: {
        name: 'Expired Test Company',
        email: expiredEmail,
        phone: '9000000001',
        plan: 'TRIAL',
        trialStartDate: new Date(Date.now() - 10 * 24 * 60 * 60 * 1000), // 10 days ago
        trialEndDate:   new Date(Date.now() - 3  * 24 * 60 * 60 * 1000), // 3 days ago (EXPIRED)
        isActive: true,
        status: 'ACTIVE',
      },
    });

    await prisma.user.create({
      data: {
        name: 'Expired User',
        email: expiredEmail,
        password,
        role: 'ADMIN',
        status: 'ACTIVE',
        companyId: expiredCompany.id,
      },
    });

    console.log('\n🔴 EXPIRED TRIAL account created:');
    console.log('   Email   :', expiredEmail);
    console.log('   Password: test123');
    console.log('   Trial   : Expired 3 days ago');
  } else {
    console.log('\n🔴 Expired trial account already exists:', expiredEmail);
  }

  // ── 3. PAID PLAN (₹599) account ─────────────────────────────────────
  const paidEmail = 'paid.user@test.com';
  const existingPaid = await prisma.user.findFirst({ where: { email: paidEmail } });

  if (!existingPaid) {
    const paidCompany = await prisma.company.create({
      data: {
        name: 'Paid Test Company',
        email: paidEmail,
        phone: '9000000002',
        plan: 'STARTER',
        trialStartDate: new Date(Date.now() - 15 * 24 * 60 * 60 * 1000),
        trialEndDate:   new Date(Date.now() + 20 * 24 * 60 * 60 * 1000), // expires in 20 days
        isActive: true,
        status: 'ACTIVE',
      },
    });

    const paidUser = await prisma.user.create({
      data: {
        name: 'Paid User',
        email: paidEmail,
        password,
        role: 'ADMIN',
        status: 'ACTIVE',
        companyId: paidCompany.id,
      },
    });

    // Create a SUCCESS payment record for ₹599
    await prisma.payment.create({
      data: {
        companyId: paidCompany.id,
        planId: plan599.id,
        amount: 599,
        currency: 'INR',
        status: 'SUCCESS',
        transactionId: 'TEST_TXN_' + Date.now(),
        paymentDate: new Date(),
      },
    });

    console.log('\n🟢 PAID PLAN (₹599) account created:');
    console.log('   Email   :', paidEmail);
    console.log('   Password: test123');
    console.log('   Plan    : STARTER (₹599)');
    console.log('   Expires : in 20 days');
  } else {
    console.log('\n🟢 Paid plan account already exists:', paidEmail);
  }

  console.log('\n─────────────────────────────────────────');
  console.log('✅ Test seed complete. Login credentials:');
  console.log('');
  console.log('  🔴 EXPIRED TRIAL');
  console.log('     Email   : expired.trial@test.com');
  console.log('     Password: test123');
  console.log('');
  console.log('  🟢 PAID STARTER (₹599)');
  console.log('     Email   : paid.user@test.com');
  console.log('     Password: test123');
  console.log('─────────────────────────────────────────');
}

main()
  .catch((e) => { console.error('❌ Seed failed:', e); process.exit(1); })
  .finally(() => prisma.$disconnect());
