require 'rails_helper'

RSpec.describe RefundEmailService do
  let!(:admin) { create(:admin_user) }
  let(:customer) { create(:customer) }
  let(:workshop) { create(:workshop) }
  let(:booking) { create(:booking, customer: customer, workshop: workshop) }
  let(:refund) { create(:refund, customer: customer, booking: booking) }

  let(:api_double) { instance_double(SibApiV3Sdk::TransactionalEmailsApi) }

  before do
    allow(RefundEmailService).to receive(:api).and_return(api_double)
    allow(api_double).to receive(:send_transac_email)
  end

  describe ".customer_refund_requested" do
    it "sends refund request email to customer" do
      described_class.customer_refund_requested(refund)

      expect(api_double).to have_received(:send_transac_email)
    end
  end

  describe ".admin_refund_requested" do
    it "sends refund request email to admin" do
      described_class.admin_refund_requested(refund)

      expect(api_double).to have_received(:send_transac_email)
    end
  end

  describe ".customer_refund_success" do
    it "sends refund success email to customer" do
      described_class.customer_refund_success(refund)

      expect(api_double).to have_received(:send_transac_email)
    end
  end

  describe ".admin_refund_success" do
    it "sends refund success email to admin" do
      described_class.admin_refund_success(refund)

      expect(api_double).to have_received(:send_transac_email)
    end
  end
end