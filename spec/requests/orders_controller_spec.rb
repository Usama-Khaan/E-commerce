require 'rails_helper'

RSpec.describe "Orders", type: :request do
  let(:user) { FactoryBot.create(:user, confirmed_at: Time.now) }

  before do
    sign_in user
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new order" do
        create(:cart, user: user)
        order_attributes = attributes_for(:order)
        post '/orders', params: { order: order_attributes }
        expect(response).to have_http_status(:found)
        expect(Order.count).to eq(1)
      end
    end
  end
end
