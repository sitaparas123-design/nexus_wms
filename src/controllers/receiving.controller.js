const receivingService = require('../services/receiving.service');
const { successResponse, errorResponse, paginatedResponse } = require('../utils/responseHandler');

exports.createReceiving = async (req, res) => {
  try {
    let companyId = req.user.companyId || req.user.originalCompanyId;
    if (!companyId) {
      const prisma = require('../utils/prisma');
      const defaultCompany = await prisma.company.findFirst();
      if (!defaultCompany) throw new Error('No company found in database');
      companyId = defaultCompany.id;
    }
    const receiving = await receivingService.createReceiving(companyId, req.user.id, req.body);
    return successResponse(res, receiving, 'Receiving order created successfully', 201);
  } catch (error) {
    return errorResponse(res, error.message, 400);
  }
};

exports.getReceivings = async (req, res) => {
  try {
    const { items, meta } = await receivingService.getReceivings(req.user.companyId, req.query);
    return paginatedResponse(res, items, meta, 'Receiving orders retrieved successfully');
  } catch (error) {
    return errorResponse(res, error.message, 500);
  }
};

exports.getReceivingById = async (req, res) => {
  try {
    const receiving = await receivingService.getReceivingById(req.params.id, req.user.companyId);
    return successResponse(res, receiving, 'Receiving order retrieved successfully');
  } catch (error) {
    return errorResponse(res, error.message, 404);
  }
};

exports.processInspection = async (req, res) => {
  try {
    const receiving = await receivingService.processInspection(req.params.id, req.user.companyId, req.user.id, req.body);
    return successResponse(res, receiving, 'Quality inspection processed successfully');
  } catch (error) {
    return errorResponse(res, error.message, 400);
  }
};

exports.completeReceivingAndPutaway = async (req, res) => {
  try {
    const result = await receivingService.completeReceivingAndPutaway(req.params.id, req.user.companyId, req.user.id, req.body);
    return successResponse(res, result, 'Receiving completed, lots created, and putaway performed successfully');
  } catch (error) {
    return errorResponse(res, error.message, 400);
  }
};
