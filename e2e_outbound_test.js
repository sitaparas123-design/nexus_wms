const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  console.log('--- Phase 3: Outbound Operations (API Simulation) ---');

  // Fetch contextual data
  const company = await prisma.company.findFirst({ where: { name: 'Amazon Logistics' } });
  const client = await prisma.client.findFirst({ where: { name: 'Amazon Retail' } });
  const product = await prisma.product.findFirst({ where: { sku: 'AMZ-ECHO-01' } });
  const user = await prisma.user.findFirst({ where: { email: 'clerk@amazon.test' } });
  const warehouse = await prisma.warehouse.findFirst({ where: { companyId: company.id } });

  if (!company || !client || !product || !user) {
    throw new Error('Required test data not found. Please ensure Phase 1 & 2 completed.');
  }

  // 1. Create Sales Order
  const salesOrder = await prisma.salesOrder.create({
    data: {
      companyId: company.id,
      clientId: client.id,
      orderNumber: `SO-${new Date().getFullYear()}-${Math.floor(1000 + Math.random() * 9000)}`,
      status: 'APPROVED', // Normally goes PENDING -> APPROVED via manager
      totalCost: 600,
      items: {
        create: [
          {
            productId: product.id,
            quantity: 10
          }
        ]
      }
    },
    include: { items: true }
  });
  console.log('✅ Created Sales Order: ' + salesOrder.orderNumber);

  // 2. Mock a Pick List generation (normally done when SO is APPROVED and ready for picking)
  const pickList = await prisma.pickList.create({
    data: {
      companyId: company.id,
      orderId: salesOrder.id,
      status: 'PENDING',
      items: {
        create: [
          {
            productId: product.id,
            targetQuantity: 10,
            pickedQuantity: 0,
            binLocation: 'RCV-01'
          }
        ]
      }
    },
    include: { items: true }
  });
  console.log('✅ Generated Pick List for SO: ' + salesOrder.orderNumber);

  // 3. Complete Pick
  // Update PickList status and SO status
  await prisma.pickList.update({
    where: { id: pickList.id },
    data: { status: 'COMPLETED' }
  });
  await prisma.pickListItem.update({
    where: { id: pickList.items[0].id },
    data: { pickedQuantity: 10 }
  });
  await prisma.salesOrder.update({
    where: { id: salesOrder.id },
    data: { status: 'READY_TO_SHIP' }
  });
  console.log('✅ Completed Picking Process');

  // 4. Create Shipment
  const shipment = await prisma.shipment.create({
    data: {
      companyId: company.id,
      orderId: salesOrder.id,
      trackingNumber: `TRK-${Math.floor(100000000 + Math.random() * 900000000)}`,
      carrier: 'FedEx',
      status: 'SHIPPED',
      recipient: client.name,
      destination: '123 Retail Ave'
    }
  });

  await prisma.salesOrder.update({
    where: { id: salesOrder.id },
    data: { status: 'SHIPPED' }
  });
  console.log('✅ Shipped Order! Tracking: ' + shipment.trackingNumber);

  console.log('\n🎉 Phase 3 Complete! Outbound flow successful.');
}

main()
  .catch(e => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
