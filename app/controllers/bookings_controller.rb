class BookingsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @workshop = Workshop.find(params[:workshop_id])

    booking = current_customer.bookings.create!(
      workshop: @workshop,
      # full_name: params[:full_name],
      # email: params[:email],
      # contact_number: params[:contact_number],
      no_of_tickets: params[:no_of_tickets],
      # state: "pending"
    )

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'inr',
          product_data: {
            name: @workshop.name
          },
          unit_amount: (@workshop.registration_fee * 100).to_i
        },
        quantity: booking.no_of_tickets
      }],
      mode: 'payment',
      success_url: success_bookings_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: workshop_url(@workshop),
      metadata: {
        booking_id: booking.id
      }
    )

    # booking.update(stripe_session_id: session.id)

    redirect_to session.url, allow_other_host: true
  end


  def success
  session = Stripe::Checkout::Session.retrieve(params[:session_id])

  booking_id = session.metadata["booking_id"]
  booking = Booking.find(booking_id)

  redirect_to workshop_path(booking.workshop),
              notice: "Payment successful!"
end

end
