class CartsController < ApplicationController
  include FindProduct
  before_action :check_user_cart, :find_product, only: %i[add_product remove_product]

  def add_product
    line_item = @cart.line_items.build(product: @product)
    redirect_to cart_path(@cart), notice: 'Product added to cart.' if line_item.save
  end

  def remove_product
    @cart.products.delete(@product)
    redirect_to cart_path(@cart), notice: 'Product removed from cart.'
  end

  def show
    @cart = current_user.cart
  end

  private

  def check_user_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
