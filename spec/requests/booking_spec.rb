require 'rails_helper'

RSpec.describe "Bookings", type: :request do
  let(:customer) { create(:customer) }
  let(:workshop) { create(:workshop, registration_fee: 1000) }

  before do
    sign_in customer
  end

  describe "POST /bookings" do
    before do
      allow(Stripe::Checkout::Session).to receive(:create)
        .and_return(double(url: "http://stripe.test"))
    end

    it "creates booking and redirects to Stripe" do
      expect {
        post bookings_path, params: {
          workshop_id: workshop.id,
          no_of_tickets: 2
        }
      }.to change(Booking, :count).by(1)

      expect(response).to redirect_to("http://stripe.test")
    end
  end
end