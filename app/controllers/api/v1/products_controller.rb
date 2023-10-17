class Api::V1::ProductsController < ApplicationController
  def index
    @products = Product.all
    render json: @products, status: 200
  end
end
