
const getSerialPort = require('../serialPortManager');

// Get the serial port instance from the first file
const port = getSerialPort();



///**********COMMAND FOR SEVO MOTOR */**************************************************** */
function sendCommandforServoMotor(command) {
    port.write(command);
}

///**********END SERVO MOTOR COMMAND */**************************************************** */


module.exports = { sendCommandforServoMotor };

