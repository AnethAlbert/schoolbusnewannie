

/*********************************************THIS WORK FINE **************************************** */

const express = require('express');
const router = express.Router();
const {sendCommandDetectFingerprint} = require('./arduino');
const {sendCommandEnrollFingerprint} = require('./arduino');
const {sendId} = require('./arduino');
const {sendCommandDeleteFingerprint}= require('./arduino');
const {sendCommandEmptyFingerprint} = require('./arduino');



router.get('/detection', async (req, res) => {
  try {
      // Send command to Arduino for fingerprint detection and wait for the ID
      const fingerprintID = await sendCommandDetectFingerprint('1');
      
      // Send the fingerprint ID as the response
      res.send(fingerprintID);
  } catch (error) {
      console.error('Error during fingerprint detection:', error);
      res.status(500).send('No fingerPrint Found for this user ');
  }
});




router.post('/enroll', async (req, res) => {
  try {
      const { fingerPrintId } = req.body;
      
      // Send command to Arduino for fingerprint enrollment and wait for completion
      const enrollmentSuccessful = await sendCommandEnrollFingerprint('2', fingerPrintId);
  
      // Once enrollment is completed and ID is received, send response
      if (enrollmentSuccessful) {
          res.send(`Fingerprint enrollment completed successfully with id ${fingerPrintId}`);
      } else {
          res.status(500).send('Fingerprint enrollment failed');
      }
  } catch (error) {
      console.error('Error during fingerprint enrollment:', error);
      res.status(500).send('Error during fingerprint enrollment');
  }
});

router.post('/delete', async (req, res) => {
  try {
      const { fingerPrintId } = req.body;
      
      // Send command to Arduino for fingerprint enrollment and wait for completion
      const DeleteSuccessful = await sendCommandDeleteFingerprint('3', fingerPrintId);
  
      // Once enrollment is completed and ID is received, send response
      if (DeleteSuccessful) {
          res.send(`Fingerprint delete completed successfully with id ${fingerPrintId}`);
      } else {
          res.status(500).send('Fingerprint delete failed');
      }
  } catch (error) {
      console.error('Error during fingerprint delete:', error);
      res.status(500).send('Error during fingerprint delete');
  }
}
);



router.post('/emptyDatabase', (req, res) => {
  // Send command to Arduino for fingerprint detection
    sendCommandEmptyFingerprint('4'); 
  res.send('Now finger print sensor Database is Empty!!!');
});



module.exports = router;

//************************************************************************************************************************************ */