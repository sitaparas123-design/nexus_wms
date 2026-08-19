const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function runTest() {
  let companyId = null;
  try {
    console.log("=== STEP 1: Creating Test Company ===");
    const company = await prisma.company.create({
      data: {
        name: "Test Company ABC",
        email: "testabc@company.com"
      }
    });
    companyId = company.id;
    console.log(`Created Company: ${company.name} (ID: ${companyId})`);

    console.log("\n=== STEP 2: Creating Related Records ===");
    
    // 1. Users (Manager, Clerk, Client)
    const suffix = Date.now();
    const manager = await prisma.user.create({ data: { name: "Manager", email: `mgr${suffix}@abc.com`, password: "x", role: "WAREHOUSE_MANAGER", companyId } });
    const clerk = await prisma.user.create({ data: { name: "Clerk", email: `clrk${suffix}@abc.com`, password: "x", role: "INVENTORY_CLERK", companyId } });
    
    const client = await prisma.client.create({ data: { name: "Test Client", email: `client${suffix}@abc.com`, companyId } });
    const clientUser = await prisma.user.create({ data: { name: "Client", email: `client_usr${suffix}@abc.com`, password: "x", role: "CLIENT", companyId } });

    // 2. Facility / Warehouse
    const warehouse = await prisma.warehouse.create({ data: { name: "WH-1", companyId } });
    
    // 3. Location
    const location = await prisma.location.create({ data: { name: "Loc-1", warehouse: "WH-1", zone: "A", aisle: "1", rack: "1", shelf: "1", companyId } });

    // 4. Products
    const category = await prisma.category.create({ data: { name: "Cat", companyId } });
    const product1 = await prisma.product.create({ data: { name: "Prod 1", sku: "P1", categoryId: category.id, companyId, availableStock: 100 } });
    const product2 = await prisma.product.create({ data: { name: "Prod 2", sku: "P2", categoryId: category.id, companyId, availableStock: 50 } });

    // 5. Receiving
    const receiving = await prisma.receiving.create({
      data: {
        receivingNumber: `RCV-${Date.now()}`,
        supplier: "Test Supplier",
        poNumber: "PO-1",
        status: "COMPLETED",
        companyId,
        items: {
          create: [{ productId: product1.id, expectedQty: 10, receivedQty: 10, companyId }]
        }
      }
    });

    // 6. Sales Order & Invoice
    const salesOrder = await prisma.salesOrder.create({
      data: {
        orderNumber: "SO-1",
        clientId: client.id,
        companyId,
        status: "SHIPPED",
        items: { create: [{ productId: product1.id, quantity: 5 }] }
      }
    });
    
    const invoice = await prisma.invoice.create({
      data: {
        invoiceNo: "INV-TEST-1",
        orderId: salesOrder.id,
        clientId: client.id,
        companyId,
        items: JSON.stringify([{ productId: product1.id, quantity: 5 }]),
        totalAmount: 100
      }
    });

    console.log("All records created successfully!");

    console.log("\n=== STEP 3: Deleting Company ===");
    // Normally done via API, but let's simulate the repository deletion
    // Wait, let's check how Company delete works in the codebase first.
    // I will just use Prisma to delete the company and see if cascade works.
    await prisma.company.delete({ where: { id: companyId } });
    console.log("Company deleted!");

  } catch (err) {
    console.error("ERROR during creation or deletion:", err.message);
  } finally {
    if (companyId) {
      console.log("\n=== STEP 4 & 5: Checking for Orphaned Records ===");
      const modelsToCheck = [
        'user', 'client', 'warehouse', 'location', 
        'category', 'product', 'receiving', 
        'salesOrder', 'invoice'
      ];
      
      let orphansFound = false;
      for (const model of modelsToCheck) {
        try {
          const count = await prisma[model].count({ where: { companyId } });
          console.log(`- ${model}: ${count} records remaining`);
          if (count > 0) orphansFound = true;
        } catch (e) {
          console.log(`- ${model}: Error checking (${e.message})`);
        }
      }
      
      console.log("\nFinal Verdict: " + (orphansFound ? "⚠️ Orphaned records found! Cascade delete failed or is missing." : "✅ All clean. Delete cascade works perfectly."));
    }
    await prisma.$disconnect();
  }
}

runTest();
