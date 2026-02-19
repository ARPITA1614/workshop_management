class ResendService
  def self.send_booking_confirmation(booking)
    Resend.api_key = ENV['RESEND_API_KEY']

    Resend::Emails.deliver({
      from: 'Webinari <onboarding@resend.dev>',
      to: booking.customer_email,
      subject: "Booking Confirmation - #{booking.workshop.title}",
      html: "
        <h1>Booking Confirmed!</h1>
        <p>Hello #{booking.customer_name},</p>
        <p>Your booking for <strong>#{booking.workshop.title}</strong> is confirmed.</p>
        <p>Booking ID: #{booking.booking_id}</p>
      "
    })
  end
end