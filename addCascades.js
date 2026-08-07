const fs = require('fs');
const path = require('path');

const schemaPath = path.join(__dirname, 'prisma', 'schema.prisma');
let content = fs.readFileSync(schemaPath, 'utf8');

// List of relations that should have onDelete: Cascade
const modelsToCascade = [
  'Company', 'User', 'Client', 'Warehouse', 'Category', 
  'Product', 'Receiving', 'Batch', 'InventoryTransfer', 
  'PurchaseOrder', 'PickList', 'SalesOrder', 'Location'
];

let updated = content;

const lines = updated.split('\n');
let modifications = 0;

for (let i = 0; i < lines.length; i++) {
  let line = lines[i];
  
  if (line.includes('@relation') && !line.includes('onDelete')) {
    const match = line.match(/(\w+)\??\s+@relation/);
    if (match) {
      const type = match[1];
      if (modelsToCascade.includes(type)) {
         line = line.replace(/(references:\s*\[[^\]]+\])/, '$1, onDelete: Cascade');
         lines[i] = line;
         modifications++;
      }
    }
  }
}

fs.writeFileSync(schemaPath, lines.join('\n'));
console.log(`Updated schema.prisma with Cascade Deletes. (${modifications} relations updated)`);
