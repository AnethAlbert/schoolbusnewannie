///****************************************** THIS WORK FINE ********************************************************** */

const getSerialPort = require('../serialPortManager');

// Get the serial port instance from the first file
const port = getSerialPort();


function sendCommandDetectFingerprint(command) {
    return new Promise((resolve, reject) => {
        let receivedData = '';
        let fingerprintDetected = false; // Flag to track if fingerprint is detected

        // Send command to Arduino for fingerprint detection
        port.write(command);

        // Set up a listener for data received from the Arduino
        port.on('data', onData);

        function onData(data) {
            // Accumulate received data
            receivedData += data.toString();

            // Check if the received data contains the fingerprint ID
            const idMatch = receivedData.match(/Fingerprint detected! ID:(\d+)/);
            if (idMatch) {
                const fingerprintID = idMatch[1];
                console.log('Fingerprint detected with ID:', fingerprintID);

                // Set the flag to true to indicate fingerprint detection
                fingerprintDetected = true;

                // Reset receivedData for future use
                receivedData = '';

                // Remove the event listener once fingerprint is detected
                port.removeListener('data', onData);

                // Resolve the promise with the fingerprint ID
                resolve(fingerprintID);
            }
        }

        // Set a timeout to stop listening if no fingerprint is detected
        setTimeout(() => {
            if (!fingerprintDetected) {
                // Remove the event listener
                port.removeListener('data', onData);

                // Reject the promise with a timeout error
                reject(new Error('Fingerprint detection timeout'));
                // Remove the event listener once fingerprint is detected

            }
        }, 5000); // Adjust the timeout duration as needed
    });
}


///**********END OF DETECT FINGERPRINT METHOD */**************************************************** */

async function sendCommandEnrollFingerprint(command, fingerPrintId) {
    // Send command to Arduino for fingerprint enrollment
    port.write(command);
    console.log('Trying to enrol fingerprint with ID:', fingerPrintId);

    return new Promise((resolve, reject) => {
        let receivedData = '';
        let fingerprintIDReceived = false;

        // Function to handle data received from the Arduino
        function onDataReceived(data) {
            // Accumulate received data
            receivedData += data.toString();

            // Check if the end of the expected data has been reached
            if (receivedData.includes('Stored!')) {
                // Parse the received data to determine the enrollment status
                const enrollmentSuccessful = receivedData.includes('Stored!');
                console.log('Enrollment status:', enrollmentSuccessful);

                // Reset receivedData and fingerprintIDReceived for future use
                receivedData = '';
                fingerprintIDReceived = false;

                // Remove the event listener once enrollment is completed
                port.removeListener('data', onDataReceived);

                // Resolve the promise with enrollment status
                resolve(enrollmentSuccessful);
            }

            // Check if the received data contains the fingerprint ID
            const idMatch = receivedData.match(/ID (\d+)/);
            if (idMatch && !fingerprintIDReceived) {
                const fingerprintID = idMatch[1];
                console.log('Fingerprint ID:', fingerprintID);
                fingerprintIDReceived = true;
            }

            // Check if the received data indicates to go back to initial state
            if (receivedData.includes('Press 1 for fingerprint detection, 2 for enrollment')) {
                // Reset receivedData and fingerprintIDReceived
                receivedData = '';
                fingerprintIDReceived = false;

                // Remove the event listener once the initial state is reached
                port.removeListener('data', onDataReceived);
            }
        }

        // Set up a listener for data received from the Arduino
        port.on('data', onDataReceived);

        // Send the fingerprint ID to Arduino
        port.write(fingerPrintId);
        console.log(fingerPrintId);

    });
}





function sendId(fingerPrintId) {
    // Implement the logic to send the fingerprint ID to Arduino
    port.write(fingerPrintId);
}


///**********END OF ENROLL FINGERPRINT METHOD */**************************************************** */



async function sendCommandDeleteFingerprint(command, fingerPrintId) {
    // Send command to Arduino for fingerprint enrollment
    port.write(command);

    return new Promise((resolve, reject) => {
        let receivedData = '';
        let fingerprintIDReceived = false;

        // Function to handle data received from the Arduino
        function onDataReceived(data) {
            // Accumulate received data
            receivedData += data.toString();

            // Check if the end of the expected data has been reached
            if (receivedData.includes('Deleted!')) {
                // Parse the received data to determine the enrollment status
                const DeleteSuccessful = receivedData.includes('Deleted!');
                console.log('Delete status:', DeleteSuccessful);

                // Reset receivedData and fingerprintIDReceived for future use
                receivedData = '';
                fingerprintIDReceived = false;

                // Remove the event listener once enrollment is completed
                port.removeListener('data', onDataReceived);

                // Resolve the promise with enrollment status
                resolve(DeleteSuccessful);
            }

            // Check if the received data contains the fingerprint ID
            const idMatch = receivedData.match(/ID (\d+)/);
            if (idMatch && !fingerprintIDReceived) {
                const fingerprintID = idMatch[1];
                console.log('Fingerprint ID:', fingerprintID);
                fingerprintIDReceived = true;
            }

            // Check if the received data indicates to go back to initial state
            if (receivedData.includes('Press 1 for fingerprint detection, 2 for enrollment')) {
                // Reset receivedData and fingerprintIDReceived
                receivedData = '';
                fingerprintIDReceived = false;

                // Remove the event listener once the initial state is reached
                port.removeListener('data', onDataReceived);
            }
        }

        // Set up a listener for data received from the Arduino
        port.on('data', onDataReceived);

        // Send the fingerprint ID to Arduino
        port.write(fingerPrintId);
        console.log(fingerPrintId);
    });
}





function sendId(fingerPrintId) {
    // Implement the logic to send the fingerprint ID to Arduino
    port.write(fingerPrintId);
}



///**********END OF DELETE FINGERPRINT METHOD */**************************************************** */

function sendCommandEmptyFingerprint(command) {
    // Implement the logic to send the fingerprint ID to Arduino
    port.write(command);
}

///**********END OF EMPTY FINGERPRINT METHOD */**************************************************** */

module.exports = { sendCommandDetectFingerprint, sendCommandEnrollFingerprint, sendId ,sendCommandDeleteFingerprint,sendCommandEmptyFingerprint };

