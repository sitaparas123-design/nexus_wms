const { PrismaClient } = require('@prisma/client');
const bcrypt = require('bcrypt');

const prisma = new PrismaClient();

async function main() {
  console.log('--- Phase 1: Infrastructure & User Provisioning ---');

  const hashedPassword = await bcrypt.hash('123456', 10);

  // Clean up old Amazon company to avoid unique constraints
  const oldCompany = await prisma.company.findFirst({ where: { name: 'Amazon Logistics' }});
  if (oldCompany) {
    await prisma.location.deleteMany({ where: { companyId: oldCompany.id }});
    await prisma.warehouse.deleteMany({ where: { companyId: oldCompany.id }});
    await prisma.product.deleteMany({ where: { companyId: oldCompany.id }});
    await prisma.category.deleteMany({ where: { companyId: oldCompany.id }});
    await prisma.client.deleteMany({ where: { companyId: oldCompany.id }});
    await prisma.user.deleteMany({ where: { companyId: oldCompany.id }});
    await prisma.company.delete({ where: { id: oldCompany.id }});
    console.log('🧹 Cleaned up old Amazon Logistics data');
  }

  // 1. Create Amazon Logistics Company with an active PRO plan
  const company = await prisma.company.create({
    data: {
      name: 'Amazon Logistics',
      industry: 'E-commerce',
      plan: 'PRO',
      isActive: true,
      trialStartDate: new Date(),
      trialEndDate: new Date(new Date().setFullYear(new Date().getFullYear() + 1)),
    }
  });
  console.log('✅ Created Company: Amazon Logistics (ID: ' + company.id + ')');

  // 2. Create Users (Manager, Clerk, Client)
  const users = [
    { name: 'Amazon Manager', email: 'manager@amazon.test', role: 'WAREHOUSE_MANAGER' },
    { name: 'Amazon Clerk', email: 'clerk@amazon.test', role: 'INVENTORY_CLERK' },
    { name: 'Amazon Client', email: 'client@amazon.test', role: 'CLIENT' },
  ];

  for (const u of users) {
    await prisma.user.upsert({
      where: { email: u.email },
      update: {
        companyId: company.id,
      },
      create: {
        name: u.name,
        email: u.email,
        password: hashedPassword,
        role: u.role,
        companyId: company.id,
        status: 'ACTIVE',
      }
    });
    console.log(`✅ Upserted User: ${u.email} (${u.role})`);
  }

  // 3. Create Warehouse Facility
  const warehouse = await prisma.warehouse.create({
    data: {
      companyId: company.id,
      name: 'Amazon Main Fulfillment Center',
      code: 'AMZ-FC1',
      address: '123 Seattle Way, WA',
      capacityValue: 100000,
      facilityType: 'Fulfillment Center'
    }
  });
  console.log('✅ Created Warehouse: ' + warehouse.name);

  // 4. Create Locations/Bins
  const locations = [
    { companyId: company.id, warehouse: warehouse.name, code: 'A-01-01', zone: 'Zone A', aisle: '01', rack: '01', shelf: '1', bin: '1', status: 'Active' },
    { companyId: company.id, warehouse: warehouse.name, code: 'A-01-02', zone: 'Zone A', aisle: '01', rack: '01', shelf: '2', bin: '2', status: 'Active' },
    { companyId: company.id, warehouse: warehouse.name, code: 'RCV-01', zone: 'Receiving Dock', aisle: 'RCV', rack: '0', shelf: '0', bin: '0', status: 'Active' },
    { companyId: company.id, warehouse: warehouse.name, code: 'SHP-01', zone: 'Shipping Dock', aisle: 'SHP', rack: '0', shelf: '0', bin: '0', status: 'Active' },
  ];

  for (const loc of locations) {
    await prisma.location.create({ data: loc });
  }
  console.log('✅ Created 4 Locations/Bins');

  // 5. Create Product Catalog for the Client
  const clientUser = await prisma.user.findFirst({ where: { email: 'client@amazon.test' } });
  
  // Create a Client profile
  const clientProfile = await prisma.client.create({
    data: {
      companyId: company.id,
      name: 'Amazon Retail',
      email: 'retail@amazon.test',
      status: 'ACTIVE'
    }
  });
  console.log('✅ Created Client Profile: ' + clientProfile.name);

  // Create Category
  const category = await prisma.category.create({
    data: {
      companyId: company.id,
      name: 'Electronics',
      description: 'Smart devices'
    }
  });

  const products = [
    { companyId: company.id, categoryId: category.id, sku: 'AMZ-ECHO-01', name: 'Echo Dot (5th Gen)', description: 'Smart speaker', uom: 'pcs', wholesalePrice: 49.99 },
    { companyId: company.id, categoryId: category.id, sku: 'AMZ-KNDL-01', name: 'Kindle Paperwhite', description: 'E-reader', uom: 'pcs', wholesalePrice: 139.99 },
  ];

  for (const prod of products) {
    await prisma.product.create({ data: prod });
  }
  console.log('✅ Created 2 Products (Echo Dot, Kindle)');

  console.log('\n🎉 Phase 1 Complete! Test data provisioned successfully.');
}

main()
  .catch((e) => { console.error(e); process.exit(1); })
  .finally(async () => { await prisma.$disconnect(); });
