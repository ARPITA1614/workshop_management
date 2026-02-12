require "stripe"

class StripeService
  def initialize()
    Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
  end

  def find_or_create_customer(customer)
    if customer.stripe_customer_id.present?
      stripe_customer = Stripe::Customer.retrieve(customer.stripe_customer_id)
    else
      stripe_customer = Stripe::Customer.create({
        name: customer.full_name,
        email: customer.email,
        phone: customer.contact_number
      })
      customer.update(stripe_customer_id: stripe_customer.id)
    end
    stripe_customer
  end

  def create_and_attach_payment_method(params, stripe_customer)
    # Step 1: Create a token with raw card details (safe for test mode)
    token = Stripe::Token.create({
      card: {
       number: params[:card_number].to_s.gsub(/\s+/, ""),
        exp_month: params[:exp_month],
        exp_year: params[:exp_year],
        cvc: params[:cvv]
      }
    })
    
    # Step 2: Create PaymentMethod using the token
    payment_method = Stripe::PaymentMethod.create({
      type: 'card',
      card: { token: token.id }
    })
    
    # Step 3: Attach to customer and set as default
    Stripe::PaymentMethod.attach(payment_method.id, { customer: stripe_customer.id })
    Stripe::Customer.update(stripe_customer.id, { invoice_settings: { default_payment_method: payment_method.id } })
    payment_method
  end

  def create_stripe_service_charge(amount_to_be_paid, stripe_customer_id, payment_method_id, workshop)
    payment_intent = Stripe::PaymentIntent.create({
      amount: (amount_to_be_paid * 100).to_i,
      currency: "inr",
      customer: stripe_customer_id,
      payment_method: payment_method_id,
      confirm: true,
      description: "Amount #{amount_to_be_paid} INR charged for #{workshop.name}"
    })
    payment_intent
  end
end