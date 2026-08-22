const { PrismaClient } = require('@prisma/client'); 
const prisma = new PrismaClient(); 
async function main() { 
  console.log('Pending SOs:', await prisma.salesOrder.count({ where: { status: { in: ['PENDING_REVIEW', 'PENDING_APPROVAL', 'PICKING', 'PACKING', 'PENDING'] } } })); 
  console.log('Inventory Locations Count:', await prisma.locationInventory.count()); 
  console.log('Total Location Qty:', await prisma.locationInventory.aggregate({ _sum: { quantity: true } }));
  console.log('Pending POs:', await prisma.purchaseOrder.count({ where: { status: { in: ['PENDING', 'APPROVED'] } } })); 
} 
main().catch(console.error).finally(()=>prisma.$disconnect());
