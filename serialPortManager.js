const { SerialPort } = require('serialport');
const port = new SerialPort({ path: 'COM4', baudRate: 9600 });

// Define the serial port you are using (replace 'COM5' with your actual port)
//const port = new SerialPort({ path: 'COM5', baudRate: 9600 });

module.exports = function getSerialPort() {
  return port;
};

let receivedData = ''; // Variable to accumulate received data

// Read data from the serial port
port.on('data', (data) => {
  receivedData += data.toString(); // Accumulate received data
  // Check if a complete message (terminated by newline) is received
  if (receivedData.includes('\n')) {
    // Split the accumulated data into lines
    const lines = receivedData.split('\n');
    // Process each line (except the last one which might be incomplete)
    for (let i = 0; i < lines.length - 1; i++) {
      console.log('Received data:', lines[i].trim()); // Process the line
    
    }
    // Save the last line if it's incomplete
    receivedData = lines[lines.length - 1];
  }
});



// Error handling
port.on('error', (err) => {
  console.error('Serial port error:', err);
});
