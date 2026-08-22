const prisma = require('../../utils/prisma');

const getPlans = async (req, res) => {
  try {
    const plans = await prisma.plan.findMany({ orderBy: { createdAt: 'desc' } });
    res.json(plans);
  } catch (error) {
    res.status(500).json({ message: 'Internal server error' });
  }
};

const createPlan = async (req, res) => {
  try {
    const { name, price, durationDays, features, isActive } = req.body;
    
    if (!name || price === undefined) {
      return res.status(400).json({ message: 'Name and price are required' });
    }

    const plan = await prisma.plan.create({
      data: { name, price: Number(price), durationDays: Number(durationDays || 30), features, isActive: isActive ?? true }
    });
    
    res.status(201).json(plan);
  } catch (error) {
    res.status(500).json({ message: 'Internal server error' });
  }
};

const updatePlan = async (req, res) => {
  try {
    const { id } = req.params;
    const { name, price, durationDays, features, isActive } = req.body;
    
    const plan = await prisma.plan.update({
      where: { id },
      data: {
        ...(name && { name }),
        ...(price !== undefined && { price: Number(price) }),
        ...(durationDays !== undefined && { durationDays: Number(durationDays) }),
        ...(features && { features }),
        ...(isActive !== undefined && { isActive })
      }
    });
    
    res.json(plan);
  } catch (error) {
    res.status(500).json({ message: 'Internal server error' });
  }
};

const deletePlan = async (req, res) => {
  try {
    const { id } = req.params;
    await prisma.plan.delete({ where: { id } });
    res.json({ message: 'Plan deleted successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Internal server error' });
  }
};

const getPublicPlans = async (req, res) => {
  try {
    const plans = await prisma.plan.findMany({ 
      where: { isActive: true },
      orderBy: { price: 'asc' } 
    });
    res.json(plans);
  } catch (error) {
    res.status(500).json({ message: 'Internal server error' });
  }
};

module.exports = { getPlans, createPlan, updatePlan, deletePlan, getPublicPlans };
