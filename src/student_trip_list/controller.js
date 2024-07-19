const pool = require('../../db');
const queries = require('./queries');
const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');
const nodemailer = require('nodemailer');
const twilio = require('twilio');
const axios = require('axios');
const emailService = require('../services/mail_service');
dotenv.config();




// Initialize Twilio client
const twilioClient = twilio(process.env.TWILIO_ACCOUNT_SID, process.env.TWILIO_AUTH_TOKEN);

// // Function to send SMS notification
// function sendSMSNotification(parentPhone, message) {
//   twilioClient.messages.create({
//     body: message,
//     from: process.env.TWILIO_PHONE_NUMBER, // Your Twilio phone number
//     to: parentPhone,
//   })
//   .then((message) => {
//     console.log('SMS notification sent:', message.sid);
//   })
//   .catch((error) => {
//     console.error('Error sending SMS notification:', error);
//   });
// }


async function sendSmsNotification(phoneNumber, message) {
    try {
        const response = await axios.post('https://us-central1-my-luggage-6c37b.cloudfunctions.net/sendCustomMessage', {
            data: {
                phoneNumber,
                message
            }
        });
        return response.data;
    } catch (error) {
        console.error('Error sending SMS:', error);
        throw new Error('Failed to send SMS');
    }
}


// Send Notifications to Parent
function sendNotifications(student_id) {
    return new Promise((resolve, reject) => {
        // Retrieve student info
        pool.query(queries.getStudentInfo, [student_id], (error, studentInfoResults) => {
            if (error) {
                console.error(error);
                return reject({ status: 500, json: { success: false, message: 'Internal server error' } });
            }

            console.log('Student Info:', studentInfoResults[0]);

            // Retrieve parent info
            pool.query(queries.getParentInfo, [student_id], async (error, parentResults) => {
                if (error) {
                    console.error(error);
                    return reject({ status: 500, json: { success: false, message: 'Internal server error' } });
                }

                if (!parentResults || parentResults.length === 0) {
                    console.log('Parent info not found for student:', student_id);
                    // Handle the case where parent info is not found
                    return reject({ status: 404, json: { success: false, message: 'Parent info not found' } });
                }

                console.log('Parent Info:', parentResults[0]);

                // Send notification to parent
                const parentEmail = parentResults[0].email;
                const parentPhone = parentResults[0].phone;
                const studentName = studentInfoResults[0].fname + ' ' + studentInfoResults[0].lname;
                const message = `Your student ${studentName} is now already in the bus.`;

                // Send email
                emailService.sendEmail(parentEmail, "Student on Bus Confirmation.", message);

                // Send SMS
                await sendSmsNotification(parentPhone, message);

                // Prepare response
                const response = {
                    message: 'Notification sent successfully',
                    success: true
                };

                return resolve({ status: 200, json: response });
            });
        });
    });
}

const addstudentTo_trip_list = (req, res) => {
    const { trip_id, student_id } = req.body;

    console.log('Request Body:', req.body);

    // Check if studentTrip Exists
    pool.query(queries.checkStudentTripExists, [trip_id, student_id], (error, tripResults) => {
        if (error) {
            console.error(error);
            return res.status(500).json({ success: false, message: 'Internal server error' });
        }

        if (tripResults.length === 0) {
            // Add student to student_trip_list if not already exists
            pool.query(queries.addStudentToTripList, [trip_id, student_id], (error, tripInsertResults) => {
                if (error) {
                    console.error(error);
                    return res.status(500).json({ success: false, message: 'Internal server error' });
                }

                console.log('Student added to trip list:', tripInsertResults);
                // Proceed to send notifications after adding the student
                sendNotifications(student_id)
                    .then(result => res.status(result.status).json(result.json))
                    .catch(error => res.status(error.status).json(error.json));
            });
        } else {
            console.log('Student trip already exists:', tripResults);
            // Proceed to send notifications without adding the student
            sendNotifications(student_id)
                .then(result => res.status(result.status).json(result.json))
                .catch(error => res.status(error.status).json(error.json));
        }
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
