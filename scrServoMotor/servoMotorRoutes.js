const express = require('express');
const router = express.Router();
const {sendCommandforServoMotor} = require('./arduino');

// PIN CONNECTION SERVO - ARDUINO
// RED = 5V
// BROWN = GND
// YELLOW = 9

router.post('/send-command', async (req, res) => {
    try {
        const { command } = req.body;
        
        // Send command to Arduino to controll the servo motor
          sendCommandforServoMotor(command);
    
        res.send(`Command sent Successfully to Servo Motor: ${command}`);
       
    } catch (error) {
        console.error('Error during sending servo motor command:', error);
        res.status(500).send('Error sending command to a motor');
    }
  });

  module.exports = router;