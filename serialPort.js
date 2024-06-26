const {SerialPort} = require('serialport');

// Define the serial port you are using (replace 'COM5', 'COM4' with your actual port)
const serialPort = new SerialPort({ path: 'COM9', baudRate: 9600 });

// Function to send data to the Arduino
function sendDataToArduino(data) {
    serialPort.write(data, (err) => {
        if (err) {
            console.error('Error sending data to Arduino:', err);
        } else {
            console.log('Data sent to Arduino:', data);
        }
    });
}

// Example: Sending ID to Arduino
const id = 123; // Replace with the ID you want to send
sendDataToArduino(id.toString()); // Convert ID to string before sending
