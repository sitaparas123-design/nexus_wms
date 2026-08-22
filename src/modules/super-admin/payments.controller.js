const prisma = require('../../utils/prisma');
const Razorpay = require('razorpay');
const crypto = require('crypto');

// Initialize Razorpay conditionally so it doesn't crash if keys are missing initially
const getRazorpayInstance = () => {
  if (!process.env.RAZORPAY_KEY_ID || !process.env.RAZORPAY_KEY_SECRET) {
    throw new Error('Razorpay keys are not configured in the backend');
  }
  return new Razorpay({
    key_id: process.env.RAZORPAY_KEY_ID,
    key_secret: process.env.RAZORPAY_KEY_SECRET
  });
};

const getPayments = async (req, res) => {
  try {
    const payments = await prisma.payment.findMany({
      include: {
        company: { select: { name: true, email: true } },
        plan: { select: { name: true } }
      },
      orderBy: { paymentDate: 'desc' }
    });
    res.json(payments);
  } catch (error) {
    console.error('Error fetching payments:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

const createCheckoutSession = async (req, res) => {
  try {
    const { planId, companyName, email, phone, userName, password } = req.body;
    
    const plan = await prisma.plan.findUnique({ where: { id: planId } });
    if (!plan) return res.status(404).json({ message: 'Plan not found' });
    
    // Create Razorpay Order
    const razorpay = getRazorpayInstance();
    const options = {
      amount: Math.round(plan.price * 100), // amount in smallest currency unit (paise)
      currency: "INR",
      receipt: `receipt_${Date.now()}`
    };
    
    const order = await razorpay.orders.create(options);
    
    res.json({
      orderId: order.id,
      amount: order.amount,
      currency: order.currency,
      keyId: process.env.RAZORPAY_KEY_ID
    });
    
  } catch (error) {
    console.error('Error creating checkout session:', error);
    const errorMessage = error.error?.description || error.message || 'Internal server error';
    res.status(500).json({ message: errorMessage });
  }
};

const verifyPayment = async (req, res) => {
  try {
    const { 
      razorpay_order_id, 
      razorpay_payment_id, 
      razorpay_signature,
      // User details to create account upon success
      companyName, email, phone, userName, password, planId 
    } = req.body;

    const secret = process.env.RAZORPAY_KEY_SECRET;

    // Verify signature
    const hmac = crypto.createHmac('sha256', secret);
    hmac.update(razorpay_order_id + "|" + razorpay_payment_id);
    const generated_signature = hmac.digest('hex');

    if (generated_signature !== razorpay_signature) {
      return res.status(400).json({ message: 'Payment verification failed' });
    }

    // Payment is valid, now create the company & user if they don't exist
    const bcrypt = require('bcrypt');
    const jwt = require('jsonwebtoken');
    const NotificationService = require('../../utils/notification.service');
    
    let user = await prisma.user.findFirst({ where: { email } });
    let company;
    
    const plan = await prisma.plan.findUnique({ where: { id: planId } });
    
    if (!user) {
      // Create new tenant
      const hashedPassword = await bcrypt.hash(password, 10);
      
      const trialEndDate = new Date();
      trialEndDate.setDate(trialEndDate.getDate() + (plan ? plan.durationDays : 30));

      company = await prisma.company.create({
        data: {
          name: companyName,
          email,
          phone,
          plan: plan ? plan.name : 'PAID',
          trialStartDate: new Date(),
          trialEndDate,
          isActive: true,
        }
      });

      user = await prisma.user.create({
        data: {
          name: userName,
          email,
          password: hashedPassword,
          phone,
          role: 'ADMIN',
          status: 'ACTIVE',
          companyId: company.id
        }
      });
      
      // Welcome email
      NotificationService.sendBrevoEmails([{ email: user.email, name: user.name }], 'Welcome to Nexus WMS', `Your account has been successfully created and your ${plan ? plan.name : 'Paid'} plan is active.`).catch(console.error);

    } else {
      company = await prisma.company.findUnique({ where: { id: user.companyId } });
      
      // Extend existing trial/plan
      const trialEndDate = new Date();
      trialEndDate.setDate(trialEndDate.getDate() + (plan ? plan.durationDays : 30));
      
      await prisma.company.update({
        where: { id: company.id },
        data: {
          plan: plan ? plan.name : 'PAID',
          trialEndDate,
          isActive: true
        }
      });

      // Send renewal email
      NotificationService.sendBrevoEmails(
        [{ email: user.email, name: user.name }], 
        'Plan Renewed Successfully', 
        `Your payment was successful. Your ${plan ? plan.name : 'Paid'} plan is now active until ${trialEndDate.toDateString()}.`
      ).catch(console.error);
    }

    // Record the payment
    await prisma.payment.create({
      data: {
        companyId: company.id,
        planId: planId,
        amount: plan ? plan.price : 0,
        currency: 'INR',
        status: 'SUCCESS',
        transactionId: razorpay_payment_id
      }
    });

    const token = jwt.sign(
      { id: user.id, role: user.role, companyId: user.companyId },
      process.env.JWT_SECRET,
      { expiresIn: '12h' }
    );

    res.json({
      message: 'Payment verified and account created/updated successfully',
      token,
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
        companyId: user.companyId,
        companyName: company.name
      }
    });

  } catch (error) {
    console.error('Error verifying payment:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
};

module.exports = {
  getPayments,
  createCheckoutSession,
  verifyPayment
};
