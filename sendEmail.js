const nodemailer = require('nodemailer');

async function sendEmail(to, subject, text) {
  // Create transporter with DETAILED configuration
  const transporter = nodemailer.createTransport({
    host: 'smtp.gmail.com',
    port: 587,
    secure: false, // Use TLS
    auth: {
      user: 'arpitanims@gmail.com',
      pass: 'varlovkfsomalijg', // Replace with your app password
    },
    tls: {
      rejectUnauthorized: false,
    },
    socketTimeout: 60000, // 60 seconds
    connectionTimeout: 60000, // 60 seconds
  });

  const mailOptions = {
    from: 'arpitanims@gmail.com',
    to: to,
    subject: subject,
    text: text,
  };

  try {
    const info = await transporter.sendMail(mailOptions);
    console.log('✅ Email sent successfully!');
    console.log('Message ID:', info.messageId);
    return { success: true, messageId: info.messageId };
  } catch (error) {
    console.log('❌ Error sending email:', error.message);
    return { success: false, error: error.message };
  }
}

// Test by sending to yourself
sendEmail('arpitadmn@gmail.com', 'Test Email', 'This is a test email from your app!');