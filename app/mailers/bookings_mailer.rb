require "rqrcode"

class BookingsMailer < ApplicationMailer
  def booking_confirmation(booking)
    @booking  = booking
    @customer = booking.customer
    @workshop = booking.workshop

    url = Rails.application.routes.url_helpers
            .booking_details_booking_url(@booking)

    qrcode = RQRCode::QRCode.new(url)
    png = qrcode.as_png(size: 300)

    attachments["qrcode.png"] = {
      mime_type: "image/png",
      content: png.to_s
    }
     puts "=== MAIL CONFIG ==="
    puts "Username: #{ENV['gmail_username'].inspect}"
    puts "Password set?: #{ENV['gmail_password'].present?}"

    mail(
      to: @customer.email,
      subject: "Booking Confirmation for #{@workshop.name}"
    )
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
