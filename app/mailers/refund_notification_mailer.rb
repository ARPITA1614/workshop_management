class RefundNotificationMailer < ApplicationMailer
  def customer_refund_notification(refund)
    @refund=refund
    @booking=refund.booking
    @customer=refund.customer
    @workshop=@booking.workshop
    @refundable_amount=@refund.no_of_tickets * @workshop.registration_fee
    mail to: @customer.email, subject: "Refund accepted for #{@workshop.name}"
  end

  def admin_refund_notification(refund)
    @refund=refund
    @booking=refund.booking
    @customer=refund.customer
    @workshop=@booking.workshop
    @refundable_amount=@refund.no_of_tickets * @workshop.registration_fee
    mail to: AdminUser.second.email, subject: "Refund request coming for #{@workshop.name}"
  end

  def refund_success_notification_to_customer(refund)
    @refund = refund
    @booking = refund.booking
    @customer = refund.customer
    @workshop = @booking.workshop
    mail to: @customer.email, subject: "Refund processed successfully for #{@workshop.name}"
  end

  def refund_success_notification_to_admin(refund)
    @refund = refund
    @booking = refund.booking
    @customer = refund.customer
    @workshop = @booking.workshop
    mail to: AdminUser.second.email, subject: "Thank you for processing refund for #{@workshop.name} | #{@booking.order_number}"
  end
end
