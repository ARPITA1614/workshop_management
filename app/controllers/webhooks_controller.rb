class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
     Rails.logger.info "🔥 STRIPE WEBHOOK HIT !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    endpoint_secret = ENV["STRIPE_WEBHOOK_SECRET"] || Rails.application.credentials.dig(:stripe, :webhook_secret)

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
  rescue JSON::ParserError => e
    Rails.logger.error "❌ Stripe JSON Error: #{e.message}"
    render json: { error: "Invalid payload" }, status: :bad_request
  rescue Stripe::SignatureVerificationError => e
    Rails.logger.error "❌ Stripe Signature Error: #{e.message}"
    Rails.logger.error "Using Secret: #{endpoint_secret&.first(5)}..." # Logs only first 5 chars for safety
    render json: { error: "Invalid signature" }, status: :bad_request
  end

  private

  def handle_checkout_completed(session)
    booking = Booking.find(session.metadata["booking_id"])
    return if 
    booking.stripe_transaction_id.present?

    workshop = booking.workshop
    refunded=false

    Workshop.transaction do
      workshop.lock!

      if workshop.remaining_sits >= booking.no_of_tickets
        # 1. Update Database (Instant)
        workshop.update!(
          remaining_sits: workshop.remaining_sits - booking.no_of_tickets
        )

        booking.update!(
          stripe_transaction_id: session.payment_intent,
          amount_paid: session.amount_total / 100
        )
        # 2. EMAIL MOVED OUT OF THE TRANSACTION WAIT-LINE
        # We use Thread.new to prevent the 31-second lag from blocking the UI
        # Thread.new do
        #   begin
        #     # Use a fresh database connection for the thread
        #     ActiveRecord::Base.connection_pool.with_connection do
              #  MailingJob.perform_later(booking.id)
        #     end
        #   rescue StandardError => e
        #     Rails.logger.error "Background Email Failed: #{e.message}"
        #   end
        # end
      else
        Stripe::Refund.create(payment_intent: session.payment_intent)
        refunded=true
      end
    end # Transaction ends here, UI updates INSTANTLY
    return if refunded
    begin 
     EmailService.send_booking_confirmation( booking.email,
 booking.full_name)
    rescue SibApiV3Sdk::ApiError => e
  Rails.logger.error "Brevo Status Code: #{e.code}"
  Rails.logger.error "Brevo Response Body: #{e.response_body}"
rescue => e
  Rails.logger.error "General Email Error: #{e.class}"
  Rails.logger.error "General Email Message: #{e.message}"
end
  end
end
