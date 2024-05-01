// const getSerialPort = require('./serialPortManager');

// // Get the serial port instance from the first file
// const port = getSerialPort();

// port.on('open', () => {
//     console.log('Serial port connected');
// });



// // Update sendCommandDetectFingerprint function in arduino.js
// async function sendCommandDetectFingerprint(command) {
//     return new Promise((resolve, reject) => {
//         // Send command to Arduino for fingerprint detection
//         port.write(command);

//         // Set up a listener for data received from the Arduino
//         const onDataReceived = (data) => {
//             const feedback = data.toString();
//             resolve(feedback);

//             // If "Fingerprint detected!" feedback is received, remove the listener to stop further processing
//             if (feedback.includes('Fingerprint detected!')) {
//                 port.removeListener('data', onDataReceived); // Remove the listener
//             }
//         };

//         port.on('data', onDataReceived);
//     });
// }

// // async function sendCommandDetectFingerprint(command) {
// //     return new Promise((resolve, reject) => {
// //         let feedbackReceived = false;

// //         // Send command to Arduino for fingerprint detection
// //         port.write(command);

// //         // Set up a listener for data received from the Arduino
// //         const onDataReceived = (data) => {
// //             const feedback = data.toString();

// //             // If "Fingerprint detected!" feedback is received, resolve the promise
// //             if (feedback.includes('Fingerprint detected!')) {
// //                 feedbackReceived = true;
// //                 resolve(feedback);
// //                 port.removeListener('data', onDataReceived); // Remove the listener
// //             }
// //         };

// //         port.on('data', onDataReceived);

// //         // Check if no feedback is received within a certain timeout
// //         setTimeout(() => {
// //             if (!feedbackReceived) {
// //                 reject(new Error('No feedback received within timeout'));
// //                 port.removeListener('data', onDataReceived); // Remove the listener
// //             }
// //         }, 5000); // Adjust the timeout as needed (in milliseconds)
// //     });
// // }
// // Update sendCommandDetectFingerprint function in arduino.js
// // function sendCommandDetectFingerprint(command, callback) {
// //     // Send command to Arduino for fingerprint detection
// //     port.write(command);

// //     // Set up a listener for data received from the Arduino
// //     const onDataReceived = (data) => {
// //         const feedback = data.toString();
// //         callback(null, feedback);

// //         // If "Fingerprint detected!" feedback is received, remove the listener to stop further processing
// //         if (feedback.includes('Fingerprint detected!')) {
// //             port.off('data', onDataReceived); // Remove the listener
// //         }
// //     };

// //     port.on('data', onDataReceived);
// // }
// // Update sendCommandDetectFingerprint function in arduino.js
// // function sendCommandDetectFingerprint(command, callback) {
// //     // Send command to Arduino for fingerprint detection
// //     port.write(command);

// //     // Set up a listener for data received from the Arduino
// //     port.once('data', (data) => {
// //         // Call the callback function and pass the received data to it
// //         const feedback = data.toString();
// //         callback(null, feedback);
// //     });
// // }

// // // Update sendCommandDetectFingerprint function in arduino.js
// // function sendCommandDetectFingerprint(command, callback) {
// //     // Send command to Arduino for fingerprint detection
// //     port.write(command);

// //     let feedbackReceived = false;

// //     // Set up a listener for data received from the Arduino
// //     port.on('data', (data) => {
// //         // Call the callback function and pass the received data to it
// //         const feedback = data.toString();
// //         callback(null, feedback);

// //         // Set the flag to true to indicate feedback is received
// //         feedbackReceived = true;
// //     });

// //     // Set up a timeout to handle cases where no data is received within a specific time frame
// //     const timeout = setTimeout(() => {
// //         // Check if feedback is not received within the timeout
// //         if (!feedbackReceived) {
// //             callback(new Error('Timeout occurred while waiting for feedback from Arduino'), null);
// //         }
// //     }, 10000); // Adjust the timeout value as needed (e.g., 10000 milliseconds)
// // }

// // function sendCommandDetectFingerprint(command, callback) {
// //     // Send command to Arduino for fingerprint detection
// //     port.write(command);

// //     // Set up a listener for data received from the Arduino
// //     port.once('data', (data) => { // Use 'once' instead of 'on' to listen only once
// //         // Call the callback function and pass the received data to it
// //         callback(null, data.toString()); // Pass null as the first argument to indicate success
// //     });

// //     // Set up a timeout to handle cases where no data is received within a specific time frame
// //     const timeout = setTimeout(() => {
// //         callback(new Error('Timeout occurred while waiting for data from Arduino'), null);
// //     }, 5000); // Adjust the timeout value as needed (e.g., 5000 milliseconds)
// // }

// // function sendCommandDetectFingerprint(command) {
// //     port.write(command);
// // }


// // async function sendCommandEnrollFingerprint(command, callback) {
// //     // Send command to Arduino for fingerprint enrollment
// //     port.write(command);
  
// //     // Set up a listener for data received from the Arduino
// //     port.once('data', (data) => {
// //         // Parse the received data to determine the enrollment status
// //         const receivedData = data.toString();
// //         const enrollmentSuccessful = receivedData.includes('Stored');
      
// //         // Call the callback function and pass the enrollment status to it
// //         callback(enrollmentSuccessful);
// //     });
// // }

  
// async function sendCommandEnrollFingerprint(command) {
//     port.write(command);
//     // Set up a listener for data received from the Arduino
//     port.on('data', (data) => {
//       // Call the callback function and pass the received data to it
//       callback(data.toString());
//     });
//   }
  

//  async function sendId(fingerPrintId) {
//     // Implement the logic to send the fingerprint ID to Arduino
//     port.write(fingerPrintId);
// }

// function sendCommandEmptyFingerprint(command) {
//     // Implement the logic to send the fingerprint ID to Arduino
//     port.write(command);
// }

// port.on('data', (data) => {
//     console.log('Data received from Arduino:', data.toString());
//     // Parse and handle data received from Arduino as needed
// });

// module.exports = { sendCommandDetectFingerprint, sendCommandEnrollFingerprint, sendId ,sendCommandEmptyFingerprint };

///****************************************** THIS WORK FINE ********************************************************** */

const getSerialPort = require('./serialPortManager');

// Get the serial port instance from the first file
const port = getSerialPort();

port.on('open', () => {
    console.log('Serial port connected');
});

function sendCommandDetectFingerprint(command) {
    port.write(command);
}


// async function sendCommandEnrollFingerprint(command, callback) {
//     // Send command to Arduino for fingerprint enrollment
//     port.write(command);
  
//     // Set up a listener for data received from the Arduino
//     port.once('data', (data) => {
//         // Parse the received data to determine the enrollment status
//         const receivedData = data.toString();
//         const enrollmentSuccessful = receivedData.includes('Stored');
      
//         // Call the callback function and pass the enrollment status to it
//         callback(enrollmentSuccessful);
//     });
// }

  
async function sendCommandEnrollFingerprint(command) {
    port.write(command);
    // Set up a listener for data received from the Arduino
    port.on('data', (data) => {
      // Call the callback function and pass the received data to it
      callback(data.toString());
    });
  }
  

 async function sendId(fingerPrintId) {
    // Implement the logic to send the fingerprint ID to Arduino
    port.write(fingerPrintId);
}

function sendCommandEmptyFingerprint(command) {
    // Implement the logic to send the fingerprint ID to Arduino
    port.write(command);
}

port.on('data', (data) => {
    console.log('Data received from Arduino:', data.toString());
    // Parse and handle data received from Arduino as needed
});

module.exports = { sendCommandDetectFingerprint, sendCommandEnrollFingerprint, sendId ,sendCommandEmptyFingerprint };