const { SerialPort } = require('serialport');

// Define the serial port you are using (replace 'COM5', 'COM4' with your actual port)
const serialPort = new SerialPort({ path: 'COM9', baudRate: 9600 });

let receivedData = '';// Variable to accumulate received data
let receiveGetdData = '';
// Function to process the received fingerprint data
function processFingerprintData(data) {
    // Print the received fingerprint data to the console
    console.log('Processed fingerprint data:', data);
    // Implement your logic here to further process the fingerprint data
    // For example, you could save it to a database, perform authentication, etc.
}

// Error handling
serialPort.on('error', (err) => {
    console.error('Serial port error:', err);
});

// Listen for data continuously
serialPort.on('data', (data) => {
    receivedData += data.toString(); // Accumulate received data
    // Check if a complete message (terminated by newline) is received
    if (receivedData.includes('\n')) {
        // Split the accumulated data into lines
        const lines = receivedData.split('\n');
        // Process each line (except the last one which might be incomplete)
        for (let i = 0; i < lines.length - 1; i++) {
            console.log('Received data:', lines[i].trim()); // Process the line
            // Call a function to process the received data
            processFingerprintData(lines[i].trim());
        }
        // Save the last line if it's incomplete
        receivedData = lines[lines.length - 1];
    }
});

// Function to add fingerprint id 
const GetFingerPrint = (req, res) => {
    try {
        console.log('Controller method to get Fingerprint Id is Started ....')
        // Open the serial port if not already open
        if (!serialPort.isOpen) {
            serialPort.open((err) => {
                if (err) {
                    console.error('Error opening serial port:', err);
                    return res.status(500).json({ error: 'Error opening serial port' });
                }
                console.log('Serial port is open.');
            });
        }


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

        // You can add further processing logic here, such as saving to a database
        res.status(200).json({ message: 'Fingerprint data received successfully.  , '});
    } catch (error) {
        console.error('Error adding fingerprint data:', error);
        res.status(500).json({ error: 'An error occurred while processing fingerprint data.' });
    }
};



///********************************************************************* */


module.exports = {
    GetFingerPrint,
};


