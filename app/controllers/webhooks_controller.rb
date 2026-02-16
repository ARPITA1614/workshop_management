class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
     Rails.logger.info "🔥 STRIPE WEBHOOK HIT !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    endpoint_secret = Rails.application.credentials.dig(:stripe, :webhook_secret)

    event = Stripe::Webhook.construct_event(
      payload,
      sig_header,
      endpoint_secret
    )

    case event.type
    when "checkout.session.completed"
      handle_checkout_completed(event.data.object)
    end

    render json: { message: "success" }
  rescue JSON::ParserError, Stripe::SignatureVerificationError
    render json: { error: "Invalid webhook" }, status: :bad_request
  end

  private

  def handle_checkout_completed(session)
  booking = Booking.find(session.metadata["booking_id"])
  workshop = booking.workshop

  Workshop.transaction do
    workshop.lock!

    if workshop.remaining_sits >= booking.no_of_tickets

      workshop.update!(
        remaining_sits: workshop.remaining_sits - booking.no_of_tickets
      )

      booking.update!(
        stripe_transaction_id: session.payment_intent,
        amount_paid: session.amount_total / 100
      )

      BookingsMailer.booking_confirmation(booking).deliver_later

    else
      Stripe::Refund.create(payment_intent: session.payment_intent)
    end
  end
end
end
