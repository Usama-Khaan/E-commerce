require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  describe "GET /index" do
    before do
      allow_any_instance_of(Api::V1::ProductsController).to receive(:authenticate_user!).and_return(nil)
    end

    it "All products are displaying" do
      get "/api/v1/products"
      expect(response).to have_http_status(:success)
    end
  end
end
