class BookingsController < ApplicationController
  # =========================
  # CREATE CHECKOUT SESSION
  # =========================
  def create
    @workshop = Workshop.find(params[:workshop_id])
    tickets = params[:no_of_tickets].to_i

    if @workshop.remaining_sits < tickets
      redirect_to workshop_path(@workshop),
                  alert: "Not enough seats available"
      return
    end

    # Create or find customer
    customer = Customer.find_or_create_by(email: params[:email]) do |c|
      c.full_name = params[:full_name]
      c.contact_number = params[:contact_number]
    end

    amount = tickets * @workshop.registration_fee

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'inr',
          product_data: {
            name: @workshop.name
          },
          unit_amount: amount * 100
        },
        quantity: tickets
      }],
      mode: 'payment',
      metadata: {
        workshop_id: @workshop.id.to_s,
        tickets: tickets.to_s,
        customer_id: customer.id.to_s
      },
      success_url: success_bookings_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: workshop_url(@workshop)
    )
    redirect_to session.url, allow_other_host: true
  end

  # =========================
  # SUCCESS AFTER PAYMENT
  # =========================
  def success
  session = Stripe::Checkout::Session.retrieve(params[:session_id])

  if session.payment_status == "paid"
    workshop_id = session.metadata["workshop_id"]
    tickets = session.metadata["tickets"].to_i
    customer_id = session.metadata["customer_id"]

    workshop = Workshop.find(workshop_id)
    customer = Customer.find(customer_id)

    # Create booking if not already created by webhook
    booking =Booking.find_or_create_by(stripe_transaction_id: session.payment_intent) do |booking|
      booking.workshop = workshop
      booking.customer = customer
      booking.no_of_tickets = tickets
      booking.amount_paid = session.amount_total / 100
    end

     BookingsMailer.booking_confirmation(booking).deliver_now

    # Decrease remaining seats
    workshop.update!(remaining_sits: workshop.remaining_sits - tickets)
  end

  redirect_to workshop_path(workshop),
              notice: "Payment successful !!! #{tickets} seat(s) booked"
end

 def booking_details
   @booking=Booking.find(params[:id])
 end

end