const transferService = require('../services/transfer.service');
const { successResponse, errorResponse, paginatedResponse } = require('../utils/responseHandler');

exports.createTransfer = async (req, res) => {
  try {
    let companyId = req.user.companyId || req.user.originalCompanyId;
    if (!companyId) {
      const prisma = require('../utils/prisma');
      const defaultCompany = await prisma.company.findFirst();
      if (!defaultCompany) throw new Error('No company found in database');
      companyId = defaultCompany.id;
    }
    const transfer = await transferService.createTransfer(companyId, req.user.id, req.body);
    return successResponse(res, transfer, 'Stock transfer completed and inventory updated', 201);
  } catch (error) {
    return errorResponse(res, error.message, 400);
  }
};

exports.getTransfers = async (req, res) => {
  try {
    const { companyId, role } = req.user;
    const filterCompanyId = (role === 'ADMIN' || !companyId) ? undefined : companyId;
    const { items, meta } = await transferService.getTransfers(filterCompanyId, req.query);
    return paginatedResponse(res, items, meta, 'Inventory transfer history retrieved successfully');
  } catch (error) {
    return errorResponse(res, error.message, 500);
  }
};

exports.getTransferById = async (req, res) => {
  try {
    const { companyId, role } = req.user;
    const filterCompanyId = (role === 'ADMIN' || !companyId) ? undefined : companyId;
    const transfer = await transferService.getTransferById(req.params.id, filterCompanyId);
    return successResponse(res, transfer, 'Transfer details retrieved successfully');
  } catch (error) {
    return errorResponse(res, error.message, 404);
  }
};
