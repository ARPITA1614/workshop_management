class HomeController < ApplicationController
  def index
    @upcoming_workshops=Workshop.upcoming_workshops
    @past_workshops=Workshop.past_workshops
  end
  def test_email
  BookingMailer.booking_confirmation(Booking.last.id).deliver_now
  render plain: "Email sent! Check your inbox."
   rescue => e
    render plain: "Error: #{e.message}"
end
end
