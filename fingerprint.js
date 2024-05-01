const pool = require('./db'); // Adjust the path as per your project structure
const getSerialPort = require('./serialPortManager'); // Import the function that exports the port

// Get the serial port instance from the first file
const port = getSerialPort();// Adjust the path as per your project structure

// Define the serial port you are using (replace 'COM5' with your actual port)
// const serialPort = new SerialPort({ path: 'COM5', baudRate: 9600 });
let receivedData = ''; // Variable to store received data

// Function to process the received fingerprint data
function processFingerprintData(data, results) {
    // Print the received fingerprint data to the console
    console.log('Received fingerprint ID:', data);

    // Print the query results
    console.log('Query results:', results);

    // This is where you can use the query results in your fingerprint capture logic
}

// Prompt the Arduino to send data by writing '1' to the serial port


// Read data from the serial port
port.on('data', (data) => {
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

                    // Call the function to process the received fingerprint data
                    processFingerprintData(digitalfingerprint, results);
                });
            });
        } else {
            console.log('Received data:', completeMessage);
        }
        
        // Reset receivedData to store the remaining data
        receivedData = receivedData.slice(endMarkerIndex + 2);
    }
});

// Export a function to use in the Express server
module.exports = function captureFingerprint() {
    // This function can be called to initiate fingerprint capture
    console.log('Fingerprint capture initiated');
    port.write('1');
};
