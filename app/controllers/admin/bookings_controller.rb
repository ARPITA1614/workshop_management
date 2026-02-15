class Admin::BookingsController < AdminController
  before_action :set_booking_with_parents, only: %i[show destroy]

  def index
    @q = Booking.ransack(params[:q])
    @bookings = @q.result.includes(:customer, :workshop)
  end

  def show
  end

  def destroy
    @booking.destroy
    redirect_to admin_bookings_path, notice: 'Booking deleted successfully'
  end

  private

  def set_booking_with_parents
    @booking = Booking.find(params[:id])
    @customer = @booking.customer
    @workshop = @booking.workshop
  end
end