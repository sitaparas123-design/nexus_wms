const prisma = require('../utils/prisma');

class ProductRepository {
  async create(data) {
    return await prisma.product.create({ data });
  }

  async findById(id, companyId) {
    return await prisma.product.findFirst({
      where: { id, ...(companyId ? { companyId } : {}), deletedAt: null },
      include: {
        categoryRef: true,
        locationInventories: {
          include: { location: true, batch: true },
        },
      },
    });
  }

  async findBySku(sku, companyId) {
    return await prisma.product.findFirst({
      where: { sku, ...(companyId ? { companyId } : {}), deletedAt: null },
    });
  }

  async findAll({ companyId, originalCompanyId, categoryId, status, search, skip, limit, sortBy, sortOrder, scope, clientCompanyId }) {
    let compFilter = companyId ? { companyId } : {};

    // For SUPER_ADMIN where companyId is null, but they have originalCompanyId, we can filter based on scope
    if (!companyId && originalCompanyId && scope) {
      if (scope === 'OWN') {
        compFilter = { companyId: originalCompanyId };
      } else if (scope === 'OTHER') {
        compFilter = clientCompanyId ? { companyId: clientCompanyId } : { companyId: { not: originalCompanyId } };
      }
    } else if (companyId && scope) {
       if (scope === 'OTHER') {
         compFilter = clientCompanyId ? { companyId: clientCompanyId } : { companyId: { not: companyId } };
       }
    }

    const where = {
      ...compFilter,
      deletedAt: null,
      ...(categoryId ? { categoryId } : {}),
      ...(status ? { status } : {}),
      ...(search
        ? {
            OR: [
              { name: { contains: search } },
              { sku: { contains: search } },
              { barcode: { contains: search } },
            ],
          }
        : {}),
    };

    const [items, total] = await Promise.all([
      prisma.product.findMany({
        where,
        skip,
        take: limit,
        orderBy: { [sortBy]: sortOrder },
        include: {
          categoryRef: true,
          locationInventories: true,
        },
      }),
      prisma.product.count({ where }),
    ]);

    return { items, total };
  }

  async update(id, companyId, data) {
    return await prisma.product.updateMany({
      where: { id, ...(companyId ? { companyId } : {}), deletedAt: null },
      data,
    });
  }

  async softDelete(id, companyId) {
    return await prisma.product.updateMany({
      where: { id, ...(companyId ? { companyId } : {}) },
      data: { deletedAt: new Date() },
    });
  }
}

module.exports = new ProductRepository();
