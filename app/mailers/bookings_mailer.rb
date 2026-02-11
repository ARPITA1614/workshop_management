class BookingsMailer < ApplicationMailer
  def booking_confirmation(booking)
    @booking  = booking
    @customer = booking.customer
    @workshop = booking.workshop

    mail(
      to: @customer.email,
      subject: "Booking Confirmation for #{@workshop.name}"
    )
  end
end
