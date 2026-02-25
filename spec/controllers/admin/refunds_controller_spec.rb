require 'rails_helper'

RSpec.describe Admin::RefundsController, type: :controller do
  let!(:admin_user) { create(:admin_user) }
  let(:customer) { create(:customer) }
  let(:workshop) { create(:workshop) }
  let(:booking) { create(:booking, customer: customer, workshop: workshop) }
  let(:refund) { create(:refund, customer: customer, booking: booking) }

#   before do
  
# end


  before do
    sign_in admin_user
    allow(StripeService).to receive(:refund).and_return(double(id: "re_123"))
    allow(RefundEmailService).to receive(:customer_refund_success)
    allow(RefundEmailService).to receive(:admin_refund_success)
  end

  describe "POST #process_refund" do
    it "marks refund as success and sends emails" do
      post :process_refund, params: { id: refund.id }

      refund.reload

      expect(refund.state).to eq("success")
      expect(RefundEmailService).to have_received(:customer_refund_success)
      expect(RefundEmailService).to have_received(:admin_refund_success)
    end
  end
end