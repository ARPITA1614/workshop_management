require 'sib-api-v3-sdk'
require 'rqrcode'
require 'base64'

class EmailService
  def self.send_booking_confirmation(booking)
    SibApiV3Sdk.configure do |config|
      config.api_key['api-key'] = ENV['BREVO_API_KEY']
    end

    customer = booking.customer
    workshop = booking.workshop

    # 1️⃣ Generate Booking URL
    url = Rails.application.routes.url_helpers
            .booking_details_booking_url(
              booking,
              host: "your-app-name.onrender.com",
              protocol: "https"
            )

    # 2️⃣ Generate QR Code
    qrcode = RQRCode::QRCode.new(url)
    png = qrcode.as_png(size: 300)

    # 3️⃣ Convert to Base64 (Brevo requires base64 attachments)
    encoded_qr = Base64.strict_encode64(png.to_s)
    Rails.logger.info "heyyyy"
    api_instance = SibApiV3Sdk::TransactionalEmailsApi.new

    send_smtp_email = SibApiV3Sdk::SendSmtpEmail.new(
      to: [{ email: customer.email, name: customer.full_name }],
      sender: {
        email: "arpitadmn@gmail.com",
        name: "Workshop Booking App"
      },
      subject: "Booking Confirmation for #{workshop.name}",
      html_content: "
        <h2>Hello #{customer.full_name},</h2>
        <p>Your booking for <strong>#{workshop.name}</strong> is confirmed 🎉</p>
        <p>Date: #{workshop.start_date}</p>
        <p>Please find your QR code attached.</p>
      ",
      attachment: [
        {
          content: encoded_qr,
          name: "qrcode.png"
        }
      ]
    )

    api_instance.send_transac_email(send_smtp_email)
  end
end