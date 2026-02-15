class RefundsController < ApplicationController
  before_action :find_booking, only: :create
  before_action :set_refund_with_parents, only: %i[edit update refund_acceptance]

  def new
    @refund = Refund.new
  end

  def edit; end

  def create
    if @booking.present?
      if @booking.is_refundable?
        @refund = Refund.create(customer_id: @booking.customer_id, booking_id: @booking.id, state: 'accepted')
        redirect_to edit_refund_path(@refund), notice: 'Your booking request is valid. Please fill other details to process your refund request.'
      else
        redirect_to new_refund_path, alert: 'You are requesting refund for a past workshop. Refund are only allowed for whorkshops wich are to be taken in the future.'
      end
    else
      redirect_to new_refund_path, alert: "You provided an invalid booking ID #{refund_params[:order_number]}. We found no booking with this booking ID. Please provide a valid booking ID."
    end
  end

  def update
    if @refund.update(no_of_tickets: refund_params[:no_of_tickets])
      send_refund_notifications
      redirect_to refund_acceptance_refund_path, notice: "You are elegible for refund for #{view_context.number_to_currency(@refund.refundable_amount(@workshop, refund_params[:no_of_tickets]))}"
    else
      redirect_to refund_acceptance_refund_path, alert: 'Something went wrong'
    end
  rescue StandardError => e
    redirect_to refund_acceptance_refund_path, alert: e.message
  end

  def refund_acceptance
    @amount_to_be_refunded = @refund.refundable_amount(@workshop, @refund.no_of_tickets)
    @accepted_refunds = Refund.accepted_refunds_for_booking(@booking.id)
    @successful_refunds = Refund.successful_refunds_for_booking(@booking.id)
  end

  private

  def send_refund_notifications
    RefundNotificationMailer.admin_refund_notification(@refund).deliver_later
    RefundNotificationMailer.customer_refund_notification(@refund).deliver_later
  end

  def set_refund_with_parents
    @refund = Refund.find(params[:id])
    @booking = @refund.booking
    @workshop = @booking.workshop
  end

  def find_booking
    @booking = Booking.find_by(order_number: refund_params[:order_number])
  end

  def refund_params
    params.require(:refund).permit(:order_number, :no_of_tickets)
  end
end