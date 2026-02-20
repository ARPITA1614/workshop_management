require 'sib-api-v3-sdk'

class RefundEmailService
  def self.configure_brevo
    SibApiV3Sdk.configure do |config|
      config.api_key['api-key'] = ENV['BREVO_API_KEY']
    end
  end

  def self.api
    configure_brevo
    SibApiV3Sdk::TransactionalEmailsApi.new
  end

  def self.sender
    {
      email: "arpitadmn@gmail.com",
      name: "Workshop Booking App"
    }
  end

  # 1️⃣ Customer – Refund Request Submitted
  def self.customer_refund_requested(refund)
    customer = refund.customer
    workshop = refund.booking.workshop

    email = SibApiV3Sdk::SendSmtpEmail.new(
      to: [{ email: customer.email, name: customer.full_name }],
      sender: sender,
      subject: "Refund Request Received for #{workshop.name}",
      htmlContent: "
        <h2>Hello #{customer.full_name},</h2>
        <p>We have received your refund request for <strong>#{workshop.name}</strong>.</p>
        <p>Our admin team will review it shortly.</p>
      "
    )

    api.send_transac_email(email)
  end

  # 2️⃣ Admin – Refund Request Submitted
  def self.admin_refund_requested(refund)
    customer = refund.customer
    workshop = refund.booking.workshop

    email = SibApiV3Sdk::SendSmtpEmail.new(
      to: [{ email: AdminUser.first.email }],
      sender: sender,
      subject: "New Refund Request - #{workshop.name}",
      htmlContent: "
        <h3>New Refund Request</h3>
        <p>Customer: #{customer.full_name}</p>
        <p>Workshop: #{workshop.name}</p>
      "
    )

    api.send_transac_email(email)
  end

  # 3️⃣ Customer – Refund Successfully Processed
  def self.customer_refund_success(refund)
    customer = refund.customer
    workshop = refund.booking.workshop
    amount = refund.no_of_tickets * workshop.registration_fee

    email = SibApiV3Sdk::SendSmtpEmail.new(
      to: [{ email: customer.email, name: customer.full_name }],
      sender: sender,
      subject: "Refund Processed Successfully - #{workshop.name}",
      htmlContent: "
        <h2>Hello #{customer.full_name},</h2>
        <p>Your refund for <strong>#{workshop.name}</strong> has been processed successfully.</p>
        <p>Refund Amount: ₹#{amount}</p>
        <p>The amount will reflect within 5-7 business days.</p>
      "
    )

    api.send_transac_email(email)
  end

  # 4️⃣ Admin – Refund Successfully Processed
  def self.admin_refund_success(refund)
    customer = refund.customer
    workshop = refund.booking.workshop

    email = SibApiV3Sdk::SendSmtpEmail.new(
      to: [{ email: AdminUser.first.email }],
      sender: sender,
      subject: "Refund Completed - #{workshop.name}",
      htmlContent: "
        <h3>Refund Completed</h3>
        <p>Customer: #{customer.full_name}</p>
        <p>Workshop: #{workshop.name}</p>
      "
    )

    api.send_transac_email(email)
  end
end