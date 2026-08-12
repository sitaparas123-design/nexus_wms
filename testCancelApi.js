const jwt = require('jsonwebtoken');

// Create a mock token for the client
const token = jwt.sign(
  { id: '7689a925-73f8-4ed0-a31b-062ae0bc1b6a', role: 'CLIENT', companyId: '01bad94b-2627-4b95-9b21-64000231a180' },
  process.env.JWT_SECRET || 'your_super_secret_jwt_key_here', // I need the actual secret from .env
  { expiresIn: '1h' }
);

console.log(token);
