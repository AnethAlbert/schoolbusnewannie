const getUserByEmail = "SELECT * FROM gurdian  WHERE email = ?";
const getUserByEmailAndPassword = "SELECT * FROM gurdian  WHERE email = ? AND password = ?";


module.exports = {
  getUserByEmail,
  getUserByEmailAndPassword
};
