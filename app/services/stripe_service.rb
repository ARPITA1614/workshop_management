class StripeService
  class << self

    def create_checkout_session(workshop:, tickets:, customer:, success_url:, cancel_url:)
  Stripe::Checkout::Session.create(
    mode: "payment",
    payment_method_types: ["card"],
    line_items: [{
      price_data: {
        currency: "inr",
        product_data: { name: workshop.name },
        unit_amount: (workshop.registration_fee * 100).to_i
      },
      quantity: tickets
    }],
    metadata: {
      workshop_id: workshop.id.to_s,
      tickets: tickets.to_s,
      customer_id: customer.id.to_s
    },
    success_url: success_url,
    cancel_url: cancel_url
  )
end


    def refund(payment_intent_id)
      Stripe::Refund.create(payment_intent: payment_intent_id)
    end

  end
end
