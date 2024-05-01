

const port = require('./serialPortManager');// Import the function that exports the port
const pool = require('./db');

// Get the serial port instance from the first file
//const port = getSerialPort();

let receivedData = '';// Variable to accumulate received data
let receiveGetdData = '';
// Function to process the received fingerprint data


// Error handling
port.on('error', (err) => {
  console.error('Serial port error:', err);
});

// Listen for data continuously
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

// Function to add fingerprint id 
const addFingerPrint = (req, res) => {
  try {
    const { FingerPrintid } = req.body;
    console.log('Received fingerprint data:', FingerPrintid);

    // Open the serial port if not already open
    if (!port.isOpen) {
      port.open((err) => {
        if (err) {
          console.error('Error opening serial port:', err);
          return res.status(500).json({ error: 'Error opening serial port' });
        }
        console.log('Serial port is open.');
      });
    }

    // Define the delay in milliseconds (60 seconds in this example)
    const delayInMillis = 100;

    // Wait for the specified delay before sending data to Arduino
    setTimeout(() => {
      const id = generateID(); // Call a function to generate ID (replace this with your logic to generate ID)
      const fingerPrintIdString = FingerPrintid.toString(); // Convert FingerPrintid to a string
      port.write(fingerPrintIdString);
    }, delayInMillis); 

    // You can add further processing logic here, such as saving to a database
    res.status(200).json({ message: 'Fingerprint data received successfully.  , '});
  } catch (error) {
    console.error('Error adding fingerprint data:', error);
    res.status(500).json({ error: 'An error occurred while processing fingerprint data.' });
  }
};

// Function to generate ID (replace this with your logic to generate ID)
function generateID() {
  // Example: generate a random ID between 1 and 127
  const randomID = Math.floor(Math.random() * 127) + 1;
  return randomID.toString(); // Convert ID to string
}


///********************************************************************* */



module.exports = {
  addFingerPrint,

};


