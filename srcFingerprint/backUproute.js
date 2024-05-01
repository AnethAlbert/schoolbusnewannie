// const express = require('express');
// const router = express.Router();
// const sendCommandDetectFingerprint = require('../arduino');
// const sendCommandEnrollFingerprint = require('../arduino');
// const sendId = require('../arduino');
// const sendCommandDeleteFingerprint= require('../arduino');
// const sendCommandEmptyFingerprint = require('../arduino');


// // Update router handler in your route file
// router.get('/detection', (req, res) => {
//   // Call sendCommandDetectFingerprint with a callback function to handle feedback
//   sendCommandDetectFingerprint('1', (err, feedback) => {
//       if (err) {
//           console.error('Error occurred:', err);
//           res.status(500).send('Error occurred while detecting fingerprint');
//           return;
//       }

//       // Handle the feedback received from the Arduino
//       console.log('Feedback from Arduino:', feedback);
//       // Send the feedback to the client
//       res.send(feedback);
//   });
// });
// // router.get('/detection', async (req, res) => {
// //   try {
// //       const feedback = await sendCommandDetectFingerprint('1');
// //       console.log('Feedback from Arduino:', feedback);
// //       res.send(feedback);
// //   } catch (error) {
// //       console.error('Error:', error);
// //       res.status(500).send('Internal Server Error');
// //   }
// // });

// // router.get('/detection', async (req, res) => {
// //   try {
// //       // Call sendCommandDetectFingerprint with a callback function to handle feedback
// //       sendCommandDetectFingerprint('1', (error, feedback) => {
// //           if (error) {
// //               console.error('Error from Arduino:', error.message);
// //               res.status(500).send('Error occurred during fingerprint detection');
// //           } else {
// //               // Handle the feedback received from the Arduino
// //               console.log('Feedback from Arduino:', feedback);
// //               // Send the feedback to the client
// //               res.send(feedback);
// //           }
// //       });
// //   } catch (error) {
// //       console.error('Error:', error);
// //       res.status(500).send('Internal server error');
// //   }
// // });


// // router.get('/detection', (req, res) => {
// //   sendCommandDetectFingerprint('1'); // Send command to Arduino for fingerprint detection
// //   res.send('Fingerprint detection command sent');
// // });

// // router.post('/enroll', async (req, res) => {
// //   const { fingerPrintId } = req.body;

// //   // Define a callback function to handle the enrollment status
// //   const enrollmentCallback = (enrollmentStatus) => {
// //     if (enrollmentStatus) {
// //       // If enrollment was successful, send the fingerprint ID
// //       sendId(fingerPrintId);
// //       res.send('Fingerprint enrolled successfully');
// //     } else {
// //       // If enrollment failed, send a failure message
// //       res.send('Fingerprint enrollment failed');
// //     }
// //   };

// //   // Send command to Arduino for fingerprint enrollment
// //   await sendCommandEnrollFingerprint('2', enrollmentCallback);
// // });



// router.post('/enroll', async (req, res) => {
//   const { fingerPrintId } = req.body;
  
//   // Send command to Arduino for fingerprint enrollment
//   await sendCommandEnrollFingerprint('2');

//   // Once enrollment command is sent, send the fingerprint ID
//   sendId(fingerPrintId);

//   res.send('Fingerprint enrollment command sent to enroll ...');
// });

// router.post('/delete', async (req, res) => {
//   const { fingerPrintId } = req.body;
  
//   // Send command to Arduino for fingerprint enrollment
//   await sendCommandDeleteFingerprint('3');

//   // Once delete command is sent, send the fingerprint ID
//   sendId(fingerPrintId);

//   res.send('Fingerprint enrollment command sent to delete ...');
// });


// router.post('/emptyDatabase', (req, res) => {
//   // Send command to Arduino for fingerprint detection
//     sendCommandEmptyFingerprint('4'); 
//   res.send('Fingerprint detection command sent');
// });



// module.exports = router;

/*********************************************THIS WORK FINE **************************************** */

const express = require('express');
const router = express.Router();
const sendCommandDetectFingerprint = require('../arduino');
const sendCommandEnrollFingerprint = require('../arduino');
const sendId = require('../arduino');
const sendCommandDeleteFingerprint= require('../arduino');
const sendCommandEmptyFingerprint = require('../arduino');



router.get('/detection', (req, res) => {
  sendCommandDetectFingerprint('1'); // Send command to Arduino for fingerprint detection
  res.send('Fingerprint detection command sent');
});

// router.post('/enroll', async (req, res) => {
//   const { fingerPrintId } = req.body;

//   // Define a callback function to handle the enrollment status
//   const enrollmentCallback = (enrollmentStatus) => {
//     if (enrollmentStatus) {
//       // If enrollment was successful, send the fingerprint ID
//       sendId(fingerPrintId);
//       res.send('Fingerprint enrolled successfully');
//     } else {
//       // If enrollment failed, send a failure message
//       res.send('Fingerprint enrollment failed');
//     }
//   };

//   // Send command to Arduino for fingerprint enrollment
//   await sendCommandEnrollFingerprint('2', enrollmentCallback);
// });



router.post('/enroll', async (req, res) => {
  const { fingerPrintId } = req.body;
  
  // Send command to Arduino for fingerprint enrollment
  await sendCommandEnrollFingerprint('2');

  // Once enrollment command is sent, send the fingerprint ID
  sendId(fingerPrintId);

  res.send('Fingerprint enrollment command sent to enroll ...');
});

router.post('/delete', async (req, res) => {
  const { fingerPrintId } = req.body;
  
  // Send command to Arduino for fingerprint enrollment
  await sendCommandDeleteFingerprint('3');

  // Once delete command is sent, send the fingerprint ID
  sendId(fingerPrintId);

  res.send('Fingerprint enrollment command sent to delete ...');
});


router.post('/emptyDatabase', (req, res) => {
  // Send command to Arduino for fingerprint detection
    sendCommandEmptyFingerprint('4'); 
  res.send('Fingerprint detection command sent');
});



module.exports = router;

//************************************************************************************************************************************ */