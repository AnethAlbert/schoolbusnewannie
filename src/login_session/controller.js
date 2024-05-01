const jwt = require('jsonwebtoken');
//const { jwtSecret } = require('./config');
const pool = require('../../db');
const queries = require('./queries');


const loginUser = (req, res) => {
  const { email, password } = req.body;

  pool.query(queries.getUserByEmail, [email], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }

    if (!results || results.length === 0) {
      res.status(404).json({ error: 'User not found' });
      return;
    }

    const user = results[0];

    // Check if the password matches
    if (!user || user.password !== password) {
      res.status(401).json({ error: 'Incorrect password or user not found' });
      return;
    }

    // Generate a JWT token using the jwtSecret from config
    const token = jwt.sign(
      {
        id: user.id,
        fname: user.fname,
        lname: user.lname,
        email: user.email,
        phone: user.phone,
        profilepicture: user.profilepicture,
        digitalfingerprint: user.digitalfingerprint,
        role: user.role,
        user_role: user.user_role,
      },
      'tish1997!!q',
      { expiresIn: '1h' }
    );

    res.status(200).json({ message: 'Logged in successfully', token });
  });
};


module.exports = {
  loginUser,
};
