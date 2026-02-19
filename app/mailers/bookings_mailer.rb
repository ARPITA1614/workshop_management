require "rqrcode"
require "resend"
require "base64"

class BookingsMailer < ApplicationMailer
  def booking_confirmation(booking)
    @booking  = booking
    @customer = booking.customer
    @workshop = booking.workshop

    # Generate QR Code
    url = Rails.application.routes.url_helpers
            .booking_details_booking_url(@booking, protocol: 'https', host: ENV['HOST_NAME'])

    qrcode = RQRCode::QRCode.new(url)
    png = qrcode.as_png(size: 300)
    
    # Convert PNG to base64 for Resend
    qr_base64 = Base64.strict_encode64(png.to_s)

    # Send email via Resend
    Resend.api_key = ENV['RESEND_API_KEY']

    Resend::Emails.deliver({
      from: 'Webinari <onboarding@resend.dev>',
      to: @customer.email,
      subject: "Booking Confirmation for #{@workshop.name}",
      html: render_booking_email,
      attachments: [
        {
          filename: "qrcode.png",
          content: qr_base64
        }
      ]
    })
  end

  private

  def render_booking_email
    "
      <div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;'>
        <h1>Booking Confirmed! 🎉</h1>
        <p>Hello #{@customer.full_name},</p>
        <p>Your booking for <strong>#{@workshop.name}</strong> has been confirmed.</p>
         <p><strong>Booking ID:</strong> #{@booking.id}</p>
        <p>Please find your QR code attached to this email.</p>
        <p>Thank you for booking with us!</p>
      </div>
    "
  end
end
# @svg = qrcode.as_svg(
#   color: "000",
#   shape_rendering: "crispEdges",
#   module_size: 11,
#   standalone: true,
#   use_path: true
# )
#     @customer = booking.customer
#     @workshop = booking.workshop

#     mail(
#       to: @customer.email,
#       subject: "Booking Confirmation for #{@workshop.name}"
#     )
#   end

#   private

#   def booking_root_url(booking_id)
#     if Rails.env.development?
#       "http://localhost:3000/bookings/#{booking_id}/booking_details"
#     else
#       # TODO
#     end
#   end
# end
