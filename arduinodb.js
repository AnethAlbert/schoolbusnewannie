const { SerialPort } = require('serialport');
const pool = require('./db');

// Define the serial port you are using (replace 'COM5', 'COM4' with your actual port)
const serialPort = new SerialPort({ path: 'COM9', baudRate: 9600 });
let receivedData = ''; // Variable to store received data

// Open the serial port
serialPort.on('open', () => {
    console.log('Serial port is open.');
});

// Read data from the serial port
serialPort.on('data', (data) => {
    receivedData += data.toString(); // Append the received data to the existing data

    // Check if the received data contains the end marker ('\r\n')
    const endMarkerIndex = receivedData.indexOf('\r\n');
    if (endMarkerIndex !== -1) {
        // Extract the complete message
        const completeMessage = receivedData.slice(0, endMarkerIndex);

        // Check if the message contains the fingerprint ID
        const idMatch = completeMessage.match(/Found ID # (\d+)/); // Adjusted regex
        if (idMatch) {
            const digitalfingerprint = idMatch[1]; // Extract the ID from the matched result
            console.log('Received fingerprint ID:', digitalfingerprint);

            // Create a database connection and execute a query
            pool.getConnection((err, connection) => {
                if (err) {
                    console.error('Error connecting to database:', err);
                    return;
                }

                // Execute the SELECT query
                connection.query('SELECT * FROM gurdian WHERE digitalfingerprint = ?', [digitalfingerprint], (error, results) => {
                    connection.release(); // Release the connection
                    if (error) {
                        console.error('Error executing query:', error);
                        return;
                    }

                    // Print the query results
                    console.log('Query results:', results);
                });
            });
        } else {
            console.log('Received data:', completeMessage);
        }

        // Reset receivedData to store the remaining data
        receivedData = receivedData.slice(endMarkerIndex + 2);
    }
});

// Export the serialPort object along with other functions
// module.exports = {
//     serialPort, // Export the serialPort object
//     // Other functions or variables if any
// };

module.exports = serialPort;
