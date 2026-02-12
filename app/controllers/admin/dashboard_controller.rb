class Admin::DashboardController < AdminController
    def index
      @workshop_count=Workshop.count
      @upcoming_workshop_count=Workshop.upcoming_workshops.count
      @past_workshop_count=Workshop.past_workshops.count
      @customer_count=Customer.count
      @booking_count=Booking.count
      @revenue_earned=Booking.pluck(:amount_paid).sum
    end
end