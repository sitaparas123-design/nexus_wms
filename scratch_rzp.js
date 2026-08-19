require('dotenv').config();
const Razorpay = require('razorpay');

const razorpay = new Razorpay({
  key_id: process.env.RAZORPAY_KEY_ID,
  key_secret: process.env.RAZORPAY_KEY_SECRET
});

razorpay.orders.create({
  amount: 1000,
  currency: "INR",
  receipt: `receipt_${Date.now()}`
}).then(console.log).catch(err => console.error("RAZORPAY ERROR:", err));
