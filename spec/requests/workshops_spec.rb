require 'rails_helper'

RSpec.describe "Workshops", type: :request do
  let!(:workshop) { create(:workshop) }

  describe "GET /workshops" do
    it "returns success" do
      get workshops_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /workshops/:id" do
    it "shows workshop" do
      get workshop_path(workshop)
      expect(response).to have_http_status(:success)
    end
  end
end