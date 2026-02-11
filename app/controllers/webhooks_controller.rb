class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = Rails.application.credentials.dig(:stripe, :webhook_secret)

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError
      return head :bad_request
    rescue Stripe::SignatureVerificationError
      return head :bad_request
    end

    # Handle event
    if event.type == 'checkout.session.completed'
      session = event.data.object

      workshop_id = session.metadata["workshop_id"]
      tickets = session.metadata["tickets"].to_i
      customer_id = session.metadata["customer_id"]

      workshop = Workshop.find(workshop_id)
      customer = Customer.find(customer_id)

      workshop.bookings.create!(
        customer: customer,
        stripe_transaction_id: session.payment_intent,
        no_of_tickets: tickets,
        amount_paid: session.amount_total / 100
      )

      workshop.update!(
        remaining_sits: workshop.remaining_sits - tickets
      )
    end

    head :ok
  end
end