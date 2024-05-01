const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');  // Import the cors middleware
const { spawn } = require('child_process');

const gurdianProfileRoute = require('./src/gurdianProfile/routes');
const parentProfileRoute = require('./src/parentProfile/routes');
const studentProfileRoute = require('./src/studentProfile/routes');
const classRoute = require('./src/class/routes');
const busRoute = require('./src/bus/routes');
const routeRoute = require('./src/routes/routes');
const stationRoute = require('./src/station/routes');
const tripRoute = require('./src/trip_record/routes');
const psrRoute = require('./src/parent_student_relation/routes');
const login_sessionRoute = require('./src/login_session/routes');
const fingerprintRoutes = require('./srcFingerprint/routefingerprintRoutes');
const studenttriplist = require('./src/student_trip_list/routes');



require('dotenv').config(); // Load environment variables from .env file

const app = express();
const port = process.env.PORT || 8080;  // Use environment variable for port or default to 5900
const server = app.listen(3000, () => {
  console.log('Server is listening on port 3000');
});

const getSerialPort = require('./serialPortManager');

// Get the serial port instance from the first file
const portArduino = getSerialPort();



// Middleware
//app.use(bodyParser.json());
app.use(bodyParser.json({ limit: '10mb' }));

// Enable CORS for all routes
app.use(cors({ origin: '*', optionsSuccessStatus: 200 }));


// Routes
app.get('/', (req, res) => {
  res.send('Hello newPostEnock');
});

app.use('/api/v1/gurdianProfile', gurdianProfileRoute);
app.use('/api/v1/parentProfile', parentProfileRoute);
app.use('/api/v1/studentProfile', studentProfileRoute);
app.use('/api/v1/class', classRoute);
app.use('/api/v1/bus', busRoute);
app.use('/api/v1/route', routeRoute);
app.use('/api/v1/station', stationRoute);
app.use('/api/v1/trip_record', tripRoute);
app.use('/api/v1/psr', psrRoute);
app.use('/api/v1/login_session', login_sessionRoute);
app.use('/api/v1', fingerprintRoutes);
app.use('/api/v1/studenttriplist', studenttriplist);

process.stdin.setEncoding('utf8');
process.stdin.on('data', (input) => {
 

  // Log the input to the console
  console.log('Input received:', input.trim());
});

// Restart server endpoint
app.post('/restart', (req, res) => {
  // Restart the server
  res.send('Restarting server...');
  restartServer();
});

// Function to restart the server
function restartServer() {
  console.log('Restarting server...');
  process.exit(0); // This will gracefully shut down the server and it will restart automatically
}
// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send({ message: 'Something went wrong!' });
});


// Close the server gracefully when Ctrl+C is pressed
process.on('SIGINT', () => {
  console.log('\nServer shutting down... port ');
  server.close(() => {
    console.log('Server has been shut down');
    process.exit(0);
  });
});



// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send({ message: 'Something went wrong!' });
});

app.listen(port, () => {
  console.log(`Server is listening on port ${port}`);
}).on('error', err => {
  console.error('Server failed to start:', err);
});
