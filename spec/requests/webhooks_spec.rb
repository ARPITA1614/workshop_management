require 'rails_helper'
require 'ostruct'


RSpec.describe "Stripe Webhook", type: :request do
  let(:customer) { create(:customer) }
  let(:workshop) { create(:workshop, remaining_sits: 10) }
  let(:booking) { create(:booking, customer: customer, workshop: workshop, no_of_tickets: 2) }

  let(:event) do
    {
      id: "evt_test",
      type: "checkout.session.completed",
      data: {
        object: {
          metadata: { booking_id: booking.id },
          payment_intent: "pi_123",
          amount_total: 2000
        }
      }
    }
  end

  before do
  stripe_event = OpenStruct.new(
    id: "evt_test",
    type: "checkout.session.completed",
    data: OpenStruct.new(
      object: OpenStruct.new(
        metadata: OpenStruct.new(
          booking_id: booking.id
        ),
        payment_intent: "pi_123",
        amount_total: 2000
      )
    )
  )

  allow(Stripe::Webhook)
    .to receive(:construct_event)
    .and_return(stripe_event)

  allow(EmailService)
    .to receive(:send_booking_confirmation)
end
end