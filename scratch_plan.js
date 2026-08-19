const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
prisma.plan.findFirst().then(p => console.log(p)).finally(() => prisma.$disconnect());
