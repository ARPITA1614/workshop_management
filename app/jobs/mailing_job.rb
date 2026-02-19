class MailingJob < ApplicationJob
  queue_as :default

  def perform(booking_id)
    # Do something later
    booking=Booking.find(booking_id)
    BookingsMailer.booking_confirmation(booking).deliver_now
  end
end
