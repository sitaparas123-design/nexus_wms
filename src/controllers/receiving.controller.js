const receivingService = require('../services/receiving.service');
const NotificationService = require('../utils/notification.service');
const { successResponse, errorResponse, paginatedResponse } = require('../utils/responseHandler');

exports.createReceiving = async (req, res) => {
  try {
    const receiving = await receivingService.createReceiving(req.user.companyId, req.user.id, req.body);
    
    // Notify about new receiving creation
    await NotificationService.send({
      companyId: req.user.companyId,
      title: 'New Inbound Delivery',
      message: `Receiving order ${receiving.receivingNumber || receiving.id.substring(0,8)} has been created.`,
      targetRoles: ['SUPER_ADMIN', 'WAREHOUSE_MANAGER', 'INVENTORY_CLERK']
    }).catch(console.error);

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
    
    // Notify about completion
    await NotificationService.send({
      companyId: req.user.companyId,
      title: 'Inbound Delivery Completed',
      message: `Items for receiving order have been inspected and putaway. Stock is now available.`,
      targetRoles: ['SUPER_ADMIN', 'WAREHOUSE_MANAGER', 'INVENTORY_CLERK']
    }).catch(console.error);

    return successResponse(res, result, 'Receiving completed, lots created, and putaway performed successfully');
  } catch (error) {
    return errorResponse(res, error.message, 400);
  }
};
