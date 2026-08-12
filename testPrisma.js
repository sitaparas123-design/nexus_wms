const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  try {
    // 1. Get the client
    const client = await prisma.client.findFirst({ where: { email: 'client@gmail.com' } });
    if (!client) throw new Error("Client not found");
    
    console.log("Client found:", client.id, "Company:", client.companyId);

    // 2. Get a product
    const product = await prisma.product.findFirst({ where: { companyId: client.companyId } });
    if (!product) throw new Error("Product not found");

    console.log("Product found:", product.id);

    // 3. Create order
    const order = await prisma.salesOrder.create({
      data: {
        clientId: client.id,
        companyId: client.companyId,
        status: 'PENDING_REVIEW',
        totalCost: 100,
        shippingAddress: 'test',
        notes: 'test',
        priority: 'NORMAL',
        items: {
          create: [
            {
              productId: product.id,
              quantity: 1
            }
          ]
        }
      },
      include: { items: true }
    });
    console.log("Order created:", order.id);

    // 4. Create Audit Log
    const auditLog = await prisma.auditLog.create({
      data: {
        event: 'SALES_ORDER_REQUESTED',
        userId: null,
        ipAddress: '127.0.0.1'
      }
    });
    console.log("Audit log created:", auditLog.id);

  } catch(e) {
    console.error("Error occurred:", e.message || e);
  }
}

main().finally(() => prisma.$disconnect());
