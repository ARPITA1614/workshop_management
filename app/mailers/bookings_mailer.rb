require "rqrcode"

class BookingsMailer < ApplicationMailer
  def booking_confirmation(booking)
    @booking=booking
qrcode = RQRCode::QRCode.new(booking_details_booking_url(booking, host: "contagiously-flangeless-tennie.ngrok-free.dev", protocol: "https", port: nil))

png = qrcode.as_png(size: 300)
attachments["qrcode.png"]={
  mime_type: "image/png",
  content: png.to_s
}

# @svg = qrcode.as_svg(
#   color: "000",
#   shape_rendering: "crispEdges",
#   module_size: 11,
#   standalone: true,
#   use_path: true
# )
    @booking  = booking
    @customer = booking.customer
    @workshop = booking.workshop

    mail(
      to: @customer.email,
      subject: "Booking Confirmation for #{@workshop.name}"
    )
  end

  private

  def booking_root_url(booking_id)
    if Rails.env.development?
      "http://localhost:3000/bookings/#{booking_id}/booking_details"
    else
      # TODO
    end
  end
end
