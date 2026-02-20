class Admin::RefundsController < AdminController
  before_action :set_refunds

  def process_refund
    return redirect_to admin_dashboard_path,
      notice: "Refund already processed" if @refund.state == "success"
    @refund.amount_refunded = @refund.amount_to_be_refunded
    stripe_charge_id = @refund.booking.stripe_transaction_id
    stripe_refund = StripeService.refund(stripe_charge_id)
    # stripe_refund = stripe_service.create_stripe_refund(
    #   stripe_charge_id,
    #   @refund.amount_refunded
    # )

    @refund.stripe_refund_id = stripe_refund.id
    mark_success
   
    Rails.logger.info "MAILER TRIGGERED"

    #  RefundNotificationMailer.refund_success_notification_to_customer(@refund).deliver_now!
    #  RefundNotificationMailer.refund_success_notification_to_admin(@refund).deliver_now!

    redirect_to admin_dashboard_path, notice: "Refund Processed successfully"
 

  rescue Stripe::InvalidRequestError => error
    if error.message.include?("already been refunded")
      mark_success
      redirect_to admin_dashboard_path,
        notice: "Refund was already processed in Stripe."
    else
      redirect_to admin_dashboard_path, alert: error.message
    end
  end

  private

  def mark_success
    @refund.is_partial_refund =
      @refund.amount_refunded < @refund.booking.amount_paid

    @refund.state = "success"
    begin
    RefundEmailService.send_refund_processed(@refund)
    RefundEmailService.notify_admin(@refund)
    rescue  SibApiV3Sdk::ApiError => e
      Rails.logger.error "Brevo Refund Email Error: #{e.response_body}"
    end

    @refund.save!
  end

  def set_refunds
    @refund = Refund.find(params[:id])
  end
end
