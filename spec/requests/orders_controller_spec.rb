require 'rails_helper'

RSpec.describe "Orders", type: :request do
  let(:user) { FactoryBot.create(:user, confirmed_at: Time.now) }

  before do
    sign_in user
    create(:cart, user: user)
  end

  describe "POST /create" do
    context "with valid parameters" do

      subject do
        post '/orders', params: { order: attributes_for(:order) }
      end

      it "creates a new order" do
        subject
        expect(user.orders).to include(assigns(:order))
      end

      it "redirect to order path" do
        subject
        expect(response).to redirect_to(order_path(assigns(:order)))
      end
    end

    context "when creating a new order with invalid parameters" do

      subject do
        post '/orders', params: { order: { invalid_attribute: "value" } }
      end

      it "renders the 'new' template" do
        subject
        expect(response).to render_template('new')
      end

      it "it checks the unprocessable_entity status" do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
