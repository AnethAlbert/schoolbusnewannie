// Import database pool and queries
const pool = require('../../db');
const queries = require('./queries');
const mailService = require('../services/mail_service');
const smsService = require('../services/sms_service');


const sendMessageToParents = (req, res) => {
    const { message ,tripId } = req.body;
    pool.query(queries.getParentsByTripId, [tripId], (error, results) => {
        if (error) {
            console.error(error);
            res.status(500).json({ success: false, message: 'Internal server error' });
            return;
        }
        if (results.length == 0) {
            res.status(400).json({ success: false, message: 'No parent found' });
            return;
        }

        const subject = "Emergency Alert";

        results.forEach(parent => {
            mailService.sendEmail(parent.email, subject,  message);
            smsService.sendSms(parent.phone, message);
        });
        res.status(200).json({ success: true, message: 'Messages sent to all parents for this trip.' });
    });
};



module.exports = {
    sendMessageToParents
};
