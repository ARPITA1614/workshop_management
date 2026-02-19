require 'sib-api-v3-sdk'

class EmailService
  def self.send_booking_confirmation(user_email, user_name)
    Rails.logger.info "BREVO KEY PRESENT?: #{ENV['BREVO_API_KEY'].present?}"

    SibApiV3Sdk.configure do |config|
      config.api_key['api-key'] = ENV['BREVO_API_KEY']
    end
     Rails.logger.info "heyyyyyyyyyyy"
    api_instance = SibApiV3Sdk::TransactionalEmailsApi.new

    send_smtp_email = SibApiV3Sdk::SendSmtpEmail.new(
      to: [{ email: user_email, name: user_name }],
      sender: {
        email: "arpitadmn@gmail.com",
        name: "Workshop Booking App"
      },
      subject: "Booking Confirmed 🎉",
      htmlContent: "
        <h1>Hello #{user_name},</h1>
        <p>Your workshop booking is confirmed.</p>
        <p>Thank you for registering!</p>
      "
    )

    api_instance.send_transac_email(send_smtp_email)
  end
end