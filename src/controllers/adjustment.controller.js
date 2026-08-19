const adjustmentService = require('../services/adjustment.service');
const { successResponse, errorResponse, paginatedResponse } = require('../utils/responseHandler');

exports.createAdjustment = async (req, res) => {
  try {
    let companyId = req.user.companyId || req.user.originalCompanyId;
    if (!companyId) {
      const prisma = require('../utils/prisma');
      const defaultCompany = await prisma.company.findFirst();
      if (!defaultCompany) throw new Error('No company found in database');
      companyId = defaultCompany.id;
    }
    const adjustment = await adjustmentService.createAdjustment(companyId, req.user.id, req.body);
    return successResponse(res, adjustment, 'Stock adjustment processed and transaction logged', 201);
  } catch (error) {
    return errorResponse(res, error.message, 400);
  }
};

exports.getAdjustments = async (req, res) => {
  try {
    const { items, meta } = await adjustmentService.getAdjustments(req.user.companyId, req.query);
    return paginatedResponse(res, items, meta, 'Stock adjustment audit records retrieved successfully');
  } catch (error) {
    return errorResponse(res, error.message, 500);
  }
};
