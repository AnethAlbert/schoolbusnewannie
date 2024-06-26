const nodemailer = require('nodemailer');

// Configure the email transporter
const transporter = nodemailer.createTransport({
  service: 'gmail',
  host: "smtp.gmail.com" ,
  port: 587,
  auth: {
    user: 'myluggageapp@gmail.com',       // Your email address
    pass: 'voeoeyiezwetftll'           // Your email password or app-specific password
  }
});

// Function to send an email
async function sendEmail(toEmail, subject, content) {
  try {
    const mailOptions = {
      from: 'myluggageapp@gmail.com',      // Sender's email address
      to: toEmail,                        // Recipient's email address
      subject: subject,                   // Email subject
      text: content                       // Plain text content of the email
      // You can also use 'html' key for HTML content
    };

    const info = await transporter.sendMail(mailOptions);
    console.log('Email sent:', info.response);
    return true;
  } catch (error) {
    console.error('Error sending email:', error);
    return false;
  }
}

module.exports = { sendEmail }