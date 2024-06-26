import { SerialPort } from 'serialport';
import readline from 'readline';
import fetch from 'node-fetch'; // Import the node-fetch library to make HTTP requests

// Define the serial port you are using (replace 'COM5', 'COM4' with your actual port)
const serialPort = new SerialPort({ path: 'COM9', baudRate: 9600 });

let receivedData = ''; // Variable to accumulate received data

// Open the serial port
serialPort.on('open', () => {
  console.log('Serial port is open.');
});

// Read data from the serial port
serialPort.on('data', (data) => {
  receivedData += data.toString(); // Accumulate received data
  // Check if a complete message (terminated by newline) is received
  if (receivedData.includes('\n')) {
    // Split the accumulated data into lines
    const lines = receivedData.split('\n');
    // Process each line (except the last one which might be incomplete)
    for (let i = 0; i < lines.length - 1; i++) {
      console.log('Received data:', lines[i].trim()); // Process the line
      // Send the received fingerprint data to the Express server
      sendFingerprintData(lines[i].trim());
    }
    // Save the last line if it's incomplete
    receivedData = lines[lines.length - 1];
  }
});

// Error handling
serialPort.on('error', (err) => {
  console.error('Serial port error:', err);
});

async function sendFingerprintData(data) {
  try {
    const response = await fetch('http://localhost:8080/capture-fingerprint', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ fingerprintData: data }), // Send the fingerprint data as JSON
    });

    if (!response.ok) {
      throw new Error('Failed to send fingerprint data to server');
    }

    const responseData = await response.text();
    console.log('Response from server:', responseData); // Log the response from the server
  } catch (error) {
    console.error('Error sending fingerprint data to server:', error);
  }
}
