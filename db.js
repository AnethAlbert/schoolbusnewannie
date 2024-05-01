
// const mysql = require('mysql');

// const pool = mysql.createPool({
//   connectionLimit: 10,
//   user: 'tish1997',
//   password: 'tish1997!q',
//   database: 'aquartic',
//   socketPath: '/cloudsql/fiery-azimuth-393715:us-central1:tish1997', // Correct format
// });

// module.exports = pool;



const mysql = require('mysql');

const pool = mysql.createPool({
  connectionLimit: 10,
  host: '127.0.0.1', // or 'localhost'//127.0.0.1
  user: 'root',
  password: '',
  database: 'school_bus_db',
});

module.exports = pool;


// module.exports = pool;

// const mysql = require('mysql');

// const pool = mysql.createPool({
//   connectionLimit: 10,
//   socketPath: process.env.INSTANCE_CONNECTION_NAME,
//   user: process.env.DB_USER,
//   password: process.env.DB_PASS,
//   database: process.env.DB_NAME,
// });

// module.exports = pool;




















