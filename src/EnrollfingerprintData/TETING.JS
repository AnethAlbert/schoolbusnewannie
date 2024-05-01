

// const { SerialPort } = require('serialport');
// const mysql = require('mysql');

// const pool = mysql.createPool({
//   connectionLimit: 10,
//   host: '127.0.0.1', // or 'localhost'//127.0.0.1
//   user: 'root',
//   password: '',
//   database: 'school_bus_db',
// });
// // Define the serial port you are using (replace 'COM5' with your actual port)
// const serialPort = new SerialPort({ path: 'COM5', baudRate: 9600 });

// let receivedData = '';// Variable to accumulate received data
// let FingerID = '';
// let receiveGetdData = '';
// // Function to process the received fingerprint data
// function processFingerprintData(data) {
//   // Print the received fingerprint data to the console
//   console.log('Processed fingerprint data:', data);
//   // Implement your logic here to further process the fingerprint data
//   // For example, you could save it to a database, perform authentication, etc.
// }

// // Error handling
// serialPort.on('error', (err) => {
//   console.error('Serial port error:', err);
// });

// // Listen for data continuously
// // Listen for data continuously outside of the function
// serialPort.on('data', (data) => {
//   receivedData += data.toString(); // Append the received data to the existing data
//   // Check if a complete message (terminated by newline) is received
//   if (receivedData.includes('\n')) {
//     // Extract the complete message
//     const completeMessage = receivedData.trim();
//     console.log('Received complete message from Arduino:', completeMessage);
//     // Check if the message contains the fingerprint ID
//     const idMatch = completeMessage.match(/Found ID # (\d+)/);
//     if (idMatch) {
//       const digitalfingerprint = idMatch[1]; // Extract the ID from the matched result
//       console.log('Received fingerprint ID:', digitalfingerprint);
      
//       // Execute the SELECT query
//       pool.getConnection((err, connection) => {
//         if (err) {
//           console.error('Error connecting to database:', err);
//           return res.status(500).json({ error: 'Error connecting to database' });
//         }

//         connection.query('SELECT * FROM gurdian WHERE digitalfingerprint = ?', [digitalfingerprint], (error, results) => {
//           connection.release(); // Release the connection
//           if (error) {
//             console.error('Error executing query:', error);
//             return res.status(500).json({ error: 'Error executing query' });
//           }

//           // Print the query results
//           console.log('Query results:', results);
//           // You can add further processing logic here, such as saving to a database

//           // Send response after successful execution
//           res.status(200).json({ message: 'Fingerprint data received successfully.' });
//         });
//       });
//     } else {
//       console.log('Received data:', completeMessage);
//     }
    
//     // Reset receivedData to store the remaining data
//     receivedData = '';
//   }
// });

// // Function to add fingerprint id 
// const GetFingerPrint = (req, res) => {
//   try {
//     console.log('Controller method to get Fingerprint Id is Started ....')
//     // Open the serial port if not already open
//     if (!serialPort.isOpen) {
//       serialPort.open((err) => {
//         if (err) {
//           console.error('Error opening serial port:', err);
//           return res.status(500).json({ error: 'Error opening serial port' });
//         }
//         console.log('Serial port is open.');
//       });
//     }
//   } catch (error) {
//     console.error('Error adding fingerprint data:', error);
//     res.status(500).json({ error: 'An error occurred while processing fingerprint data.' });
//   }
// };



// // // Listen for data continuously
// // serialPort.on('data', (data) => {
// //   receivedData += data.toString(); // Accumulate received data
// //   // Check if a complete message (terminated by newline) is received
// //   if (receivedData.includes('\n')) {
// //     // Split the accumulated data into lines
// //     const lines = receivedData.split('\n');
// //     // Process each line (except the last one which might be incomplete)
// //     for (let i = 0; i < lines.length - 1; i++) {
// //       console.log('Received data:', lines[i].trim()); // Process the line
// //       // Call a function to process the received data
// //       processFingerprintData(lines[i].trim());
// //     }
// //     // Save the last line if it's incomplete
// //     receivedData = lines[lines.length - 1];
// //   }
// // });

// const addFingerPrint = (req, res) => {
//   try {
//     const { FingerPrintid } = req.body;
//     console.log('Received fingerprint data:', FingerPrintid);

//     // Close the serial port if it's open
//     if (serialPort.isOpen) {
//       serialPort.close((err) => {
//         if (err) {
//           console.error('Error closing serial port:', err);
//           return res.status(500).json({ error: 'Error closing serial port' });
//         }
//         console.log('Serial port is closed.');
//         // After closing the port, open a new one
//         openNewPort(FingerPrintid, res);
//       });
//     } else {
//       // If the serial port is not open, open a new one directly
//       openNewPort(FingerPrintid, res);
//     }
//   } catch (error) {
//     console.error('Error adding fingerprint data:', error);
//     res.status(500).json({ error: 'An error occurred while processing fingerprint data.' });
//   }
// };

// // Function to open a new serial port and send data to Arduino
// function openNewPort(FingerPrintid, res) {
//   // Open the serial port
//   serialPort.open((err) => {
//     if (err) {
//       console.error('Error opening serial port:', err);
//       return res.status(500).json({ error: 'Error opening serial port' });
//     }
//     console.log('Serial port is open.');

//     // Define the delay in milliseconds (100 milliseconds in this example)
//     const delayInMillis = 100;

//     // Wait for the specified delay before sending data to Arduino
//     setTimeout(() => {
//       const fingerPrintIdString = FingerPrintid.toString(); // Convert FingerPrintid to a string
//       serialPort.write(fingerPrintIdString);
//       // You can add further processing logic here, such as saving to a database
//       res.status(200).json({ message: 'Fingerprint data received successfully.' });
//     }, delayInMillis);
//   });
// }



// ///********************************************************************* */

// ///%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






// // Function to add fingerprint id 
// const GetFingerPrintt = (req, res) => {
//   try {
//     console.log('Controller method to get Fingerprint Id is Started ....')
//     // Open the serial port if not already open
//     if (!serialPort.isOpen) {
//       serialPort.open((err) => {
//         if (err) {
//           console.error('Error opening serial port:', err);
//           return res.status(500).json({ error: 'Error opening serial port' });
//         }
//         console.log('Serial port is open.');
//       });
//     }

//     let receivedData = ''; // Variable to accumulate received data

//     // Listen for data continuously
//     serialPort.on('data', (data) => {
//       receivedData += data.toString(); // Append the received data to the existing data
//       // Check if a complete message (terminated by newline) is received
//       if (receivedData.includes('\n')) {
//         // Extract the complete message
//         const completeMessage = receivedData.trim();
//         console.log('Received complete message from Arduino:', completeMessage);
//         // Check if the message contains the fingerprint ID
//         const idMatch = completeMessage.match(/Found ID # (\d+)/);
//         if (idMatch) {
//           const digitalfingerprint = idMatch[1]; // Extract the ID from the matched result
//           console.log('Received fingerprint ID:', digitalfingerprint);
          
//           // Execute the SELECT query
//           pool.getConnection((err, connection) => {
//             if (err) {
//               console.error('Error connecting to database:', err);
//               return res.status(500).json({ error: 'Error connecting to database' });
//             }

//             connection.query('SELECT * FROM gurdian WHERE digitalfingerprint = ?', [digitalfingerprint], (error, results) => {
//               connection.release(); // Release the connection
//               if (error) {
//                 console.error('Error executing query:', error);
//                 return res.status(500).json({ error: 'Error executing query' });
//               }

//               // Print the query results
//               console.log('Query results:', results);
//               // You can add further processing logic here, such as saving to a database

//               // Send response after successful execution
//               res.status(200).json({ message: 'Fingerprint data received successfully.' });
//             });
//           });
//         } else {
//           console.log('Received data:', completeMessage);
//         }
        
//         // Reset receivedData to store the remaining data
//         receivedData = '';
//       }
//     });
//   } catch (error) {
//     console.error('Error adding fingerprint data:', error);
//     res.status(500).json({ error: 'An error occurred while processing fingerprint data.' });
//   }
// };



























// // // Function to add fingerprint id 
// // const GetFingerPrint = (req, res) => {
// //   try {
// //     console.log('Controller method to get Fingerprint Id is Started ....')
// //     // Check if the serial port is already open
// //     if (!serialPort.isOpen) {
// //       // Close the existing connection if it's open
// //       serialPort.close((err) => {
// //         if (err) {
// //           console.error('Error closing serial port:', err);
// //           return res.status(500).json({ error: 'Error closing serial port' });
// //         }
// //         // Open the serial port
// //         serialPort.open((err) => {
// //           if (err) {
// //             console.error('Error opening serial port:', err);
// //             return res.status(500).json({ error: 'Error opening serial port' });
// //           }
// //           console.log('Serial port is open.');
// //           // Proceed with the database query
// //           executeDatabaseQuery(req, res);
// //         });
// //       });
// //     } else {
// //       // If the serial port is already open, proceed with the database query
// //       executeDatabaseQuery(req, res);
// //     }
// //   } catch (error) {
// //     console.error('Error adding fingerprint data:', error);
// //     res.status(500).json({ error: 'An error occurred while processing fingerprint data.' });
// //   }
// // };

// // // Function to execute the database query
// // const executeDatabaseQuery = (req, res) => {
// //   // Read data from the serial port
// //   let receivedData = ''; // Variable to accumulate received data

// //   // Listen for data continuously
// //   serialPort.on('data', (data) => {
// //     receivedData += data.toString(); // Append the received data to the existing data
// //     // Check if a complete message (terminated by newline) is received
// //     if (receivedData.includes('\n')) {
// //       // Extract the complete message
// //       const completeMessage = receivedData.trim();
// //       console.log('Received complete message from Arduino:', completeMessage);
// //       // Check if the message contains the fingerprint ID
// //       const idMatch = completeMessage.match(/Found ID # (\d+)/);
// //       if (idMatch) {
// //         const digitalfingerprint = idMatch[1]; // Extract the ID from the matched result
// //         console.log('Received fingerprint ID:', digitalfingerprint);
        
// //         // Execute the SELECT query
// //         pool.getConnection((err, connection) => {
// //           if (err) {
// //             console.error('Error connecting to database:', err);
// //             return res.status(500).json({ error: 'Error connecting to database' });
// //           }

// //           connection.query('SELECT * FROM gurdian WHERE digitalfingerprint = ?', [digitalfingerprint], (error, results) => {
// //             connection.release(); // Release the connection
// //             if (error) {
// //               console.error('Error executing query:', error);
// //               return res.status(500).json({ error: 'Error executing query' });
// //             }

// //             // Print the query results
// //             console.log('Query results:', results);
// //             // You can add further processing logic here, such as saving to a database

// //             // Send response after successful execution
// //             res.status(200).json({ message: 'Fingerprint data received successfully.' });
// //           });
// //         });
// //       } else {
// //         console.log('Received data:', completeMessage);
// //       }
      
// //       // Reset receivedData to store the remaining data
// //       receivedData = '';
// //     }
// //   });
// // };

// // module.exports = {
// //   GetFingerPrint,
// // };























// //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

// // Function to get user by fingerprint ID
// const getFingergetUser = (req, res) => {
//   try {
   
//     // Read data from the serial port
//     serialPort.on('data', (data) => {
//       receivedData += data.toString(); // Append the received data to the existing data
      
//       // Check if the received data contains the end marker ('\r\n')
//       const endMarkerIndex = receivedData.indexOf('\r\n');
//       if (endMarkerIndex !== -1) {
//           // Extract the complete message
//           const completeMessage = receivedData.slice(0, endMarkerIndex);
          
//           // Check if the message contains the fingerprint ID
//           const idMatch = completeMessage.match(/Found ID # (\d+)/); // Adjusted regex
//           if (idMatch) {
//               const digitalfingerprint = idMatch[1]; // Extract the ID from the matched result
//               console.log('Received fingerprint ID:', digitalfingerprint);
  
//               // Create a database connection and execute a query
//               pool.getConnection((err, connection) => {
//                   if (err) {
//                       console.error('Error connecting to database:', err);
//                       return;
//                   }
  
//                   // Execute the SELECT query
//                   connection.query('SELECT * FROM gurdian WHERE digitalfingerprint = ?', [digitalfingerprint], (error, results) => {
//                       connection.release(); // Release the connection
//                       if (error) {
//                           console.error('Error executing query:', error);
//                           return;
//                       }
  
//                       // Print the query results
//                       console.log('Query results:', results);
//                   });
//               });
//           } else {
//               console.log('Received data:', completeMessage);
//           }
          
//           // Reset receivedData to store the remaining data
//           receivedData = receivedData.slice(endMarkerIndex + 2);
//       }
//   });

//     // const getfingerprintId = {
//     //   id: 1,
//     // };
    
//     res.status(200).json({
//       // getfingerprintId 
//       });
//   } catch (error) {
//     console.error('Error getting user by fingerprint ID:', error);
//     res.status(500).json({ error: 'An error occurred while retrieving user data.' });
//   }
// };



// module.exports = {
//   addFingerPrint,
//   getFingergetUser,
//   GetFingerPrint,
// };


