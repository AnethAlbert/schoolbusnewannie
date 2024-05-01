
const pool = require('../../db');
const queries = require('./queries');
const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');
const nodemailer = require('nodemailer'); 
const twilio = require('twilio');
dotenv.config();




// Initialize Twilio client
const twilioClient = twilio(process.env.TWILIO_ACCOUNT_SID, process.env.TWILIO_AUTH_TOKEN);

// Function to send SMS notification
function sendSMSNotification(parentPhone, message) {
  twilioClient.messages.create({
    body: message,
    from: process.env.TWILIO_PHONE_NUMBER, // Your Twilio phone number
    to: parentPhone,
  })
  .then((message) => {
    console.log('SMS notification sent:', message.sid);
  })
  .catch((error) => {
    console.error('Error sending SMS notification:', error);
  });
}

// const addstudentTo_trip_list = (req, res) => {
//   const { trip_id, student_id } = req.body;

//   console.log('Request Body:', req.body);

//   // Check if student exists
//   pool.query(queries.checkStudentExists, [student_id], (error, studentResults) => {
//     if (error) {
//       console.error(error);
//       return res.status(500).json({ error: 'Internal server error' });
//     }

//     if (studentResults.length === 0) {
//       console.log('Student not found');
//       return res.status(404).json({ error: 'Student not found' });
//     }

//     console.log('Student found:', studentResults[0]);

//     // Add student to student_trip_list
//     pool.query(queries.addStudentToTripList, [trip_id, student_id], (error, tripResults) => {
//       if (error) {
//         console.error(error);
//         return res.status(500).json({ error: 'Internal server error' });
//       }

//       console.log('Student added to trip list:', tripResults);

//       // Retrieve student info
//       pool.query(queries.getStudentInfo, [student_id], (error, studentInfoResults) => {
//         if (error) {
//           console.error(error);
//           return res.status(500).json({ error: 'Internal server error' });
//         }

//         console.log('Student Info:', studentInfoResults[0]);

//         // Retrieve parent info
//         pool.query(queries.getParentInfo, [student_id], (error, parentResults) => {
//           if (error) {
//             console.error(error);
//             return res.status(500).json({ error: 'Internal server error' });
//           }

//           if (!parentResults || parentResults.length === 0) {
//             console.log('Parent info not found for student:', student_id);
//             // Handle the case where parent info is not found
//             return res.status(404).json({ error: 'Parent info not found' });
//           }
        
        
//           console.log('Parent Info:', parentResults[0]);

//           // Send notification to parent via email
//           const parentEmail = parentResults[0].email;
//           const studentName = studentInfoResults[0].fname;
//           const emailMessage = `Your student ${studentName} is already in the bus.`;

//           const mailOptions = {
//             from: process.env.EMAIL_USERNAME,
//             to: parentEmail,
//             subject: 'Student in Bus Notification',
//             text: emailMessage,
//           };

//           transporter.sendMail(mailOptions, function (error, info) {
//             if (error) {
//               console.error(error);
//               return res.status(500).json({ error: 'Failed to send email notification' });
//             } else {
//               console.log('Email notification sent:', info.response);
//             }
//           });

//           // Send SMS notification to parent
//           const parentPhone = parentResults[0].phone;
//           const smsMessage = `Your student ${studentName} is already in the bus.`;
//           sendSMSNotification(parentPhone, smsMessage);

//           // Prepare response
//           const response = {
//             trip_id: trip_id,
//             student_info: studentInfoResults[0],
//             parent_info: parentResults[0],
//             message: 'Student added to trip list and notifications sent successfully',
//           };

//           return res.status(200).json(response);
//         });
//       });
//     });
//   });
// };

const addstudentTo_trip_list = (req, res) => {
  const { trip_id, student_id } = req.body;

  console.log('Request Body:', req.body);

  // Check if student exists
  pool.query(queries.checkStudentExists, [student_id], (error, studentResults) => {
    if (error) {
      console.error(error);
      return res.status(500).json({ error: 'Internal server error' });
    }

    if (studentResults.length === 0) {
      console.log('Student not found');
      return res.status(404).json({ error: 'Student not found' });
    }

    console.log('Student found:', studentResults[0]);

    // Add student to student_trip_list
    pool.query(queries.addStudentToTripList, [trip_id, student_id], (error, tripResults) => {
      if (error) {
        console.error(error);
        return res.status(500).json({ error: 'Internal server error' });
      }

      console.log('Student added to trip list:', tripResults);

      // Retrieve student info
      pool.query(queries.getStudentInfo, [student_id], (error, studentInfoResults) => {
        if (error) {
          console.error(error);
          return res.status(500).json({ error: 'Internal server error' });
        }

        console.log('Student Info:', studentInfoResults[0]);

        // Retrieve parent info
        pool.query(queries.getParentInfo, [student_id], (error, parentResults) => {
          if (error) {
            console.error(error);
            return res.status(500).json({ error: 'Internal server error' });
          }

          if (!parentResults || parentResults.length === 0) {
            console.log('Parent info not found for student:', student_id);
            // Handle the case where parent info is not found
            return res.status(404).json({ error: 'Parent info not found' });
          }
        
        
          console.log('Parent Info:', parentResults[0]);

          // Send notification to parent
          const parentEmail = parentResults[0].email;
          //const parentPhone = parentResults[0].phone;
          const studentName = studentInfoResults[0].fname;
          const message = `Your student ${studentName} is already in the bus.`;

          // Send email
          const transporter = nodemailer.createTransport({
            service: 'gmail',
            host: 'smtp.gmail.com',
            tls: {
              rejectUnauthorized: false
            },
            auth: {
              user: process.env.EMAIL_USERNAME,
              pass: process.env.SMTP_PASSWORD,
            },
          });
          

          const mailOptions = {
            from: process.env.EMAIL_USERNAME,
            to: parentEmail,
            subject: 'Student in Bus Notification',
            text: message,
          };

          transporter.sendMail(mailOptions, function (error, info) {
            if (error) {
              console.error(error);
              return res.status(500).json({ error: 'Failed to send email notification' });
            } else {
              console.log('Email notification sent:', info.response);
            }
          });

          // Send SMS notification (implement as needed)

           // Send SMS notification to parent
          const parentPhone = parentResults[0].phone;
          const smsMessage = `Your student ${studentName} is already in the bus.`;
          sendSMSNotification(parentPhone, smsMessage);


          // Prepare response
          const response = {
            trip_id: trip_id,
            student_info: studentInfoResults[0],
            parent_info: parentResults[0],
            message: 'Student added to trip list and notification sent successfully',
          };

          return res.status(200).json(response);
        });
      });
    });
  });
};

const getStudentIdsByTripId = (req, res) => {
  const trip_id = req.params.id; // Access trip_id from req.params.id
  pool.query(queries.getStudentIdsByTripId, [trip_id], (error, results) => {
    if (error) {
      console.error(error);
      return res.status(500).json({ error: 'Internal server error' });
    }
    // Extract student IDs from the query results
    const studentIds = results.map(result => result.student_id);
    console.log(studentIds);
    // Return an array of objects with student_id field
   // const studentIdsResponse = studentIds.map(({ student_id }));
    console.log(studentIds);
    return res.status(200).json(studentIds);
  });
};




const getAllStudentIds = (req, res) => {
  pool.query(queries.getAllStudentIds, (error, results) => {
    if (error) {
      console.error(error);
      return res.status(500).json({ error: 'Internal server error' });
    }
    const studentIds = results.map(result => result.student_id);
    return res.status(200).json({ student_ids: studentIds });
  });
};


module.exports = {
  addstudentTo_trip_list,
  getStudentIdsByTripId,
  getAllStudentIds,
};
