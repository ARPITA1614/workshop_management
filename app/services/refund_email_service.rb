require 'sib-api-v3-sdk'

class RefundEmailService
  def self.send_refund_processed(refund)
    SibApiV3Sdk.configure do |config|
      config.api_key['api-key'] = ENV['BREVO_API_KEY']
    end

    customer = refund.customer
    workshop = refund.booking.workshop
    amount = refund.no_of_tickets * workshop.registration_fee

    api_instance = SibApiV3Sdk::TransactionalEmailsApi.new

    email = SibApiV3Sdk::SendSmtpEmail.new(
      to: [{ email: customer.email, name: customer.full_name }],
      sender: {
        email: "arpitadmn@gmail.com",
        name: "Workshop Booking App"
      },
      subject: "Refund Processed for #{workshop.name}",
      htmlContent: "
        <h2>Hello #{customer.full_name},</h2>
        <p>Your refund for <strong>#{workshop.name}</strong> has been processed successfully.</p>
        <p>Refund Amount: ₹#{amount}</p>
        <p>The amount will reflect in your account within 5-7 business days.</p>
      "
    )

    api_instance.send_transac_email(email)
  end

  def self.notify_admin(refund)
  SibApiV3Sdk.configure do |config|
    config.api_key['api-key'] = ENV['BREVO_API_KEY']
  end

  workshop = refund.booking.workshop
  customer = refund.customer

  api_instance = SibApiV3Sdk::TransactionalEmailsApi.new

  email = SibApiV3Sdk::SendSmtpEmail.new(
    to: [{ email: AdminUser.first.email }],
    sender: {
      email: "arpitadmn@gmail.com",
      name: "Workshop Booking App"
    },
    subject: "Refund Completed - #{workshop.name}",
    htmlContent: "
      <h3>Refund Completed</h3>
      <p>Customer: #{customer.full_name}</p>
      <p>Workshop: #{workshop.name}</p>
    "
  )

  api_instance.send_transac_email(email)
  end
end