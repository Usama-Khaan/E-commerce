require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  describe "GET /index" do
    it "All products are displaying" do
      get "/api/v1/products/index"
      expect(response).to have_http_status(:success)
    end
  end
end
