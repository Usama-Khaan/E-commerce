class CartsController < ApplicationController
  include FindProduct
  before_action :find_product, only: %i[add_product remove_product]
  before_action :check_user_cart

  def add_product
    line_item = @cart.line_items.find_by(product: @product)
    if line_item
      if line_item.line_items_quantity_was.nil?
        line_item.line_items_quantity = 1
      else
        line_item.line_items_quantity += 1
      end
    else
      line_item = @cart.line_items.build(product: @product, line_items_quantity: 1)
    end
    redirect_to cart_path(@cart), notice: 'Product added to cart.' if line_item.save
  end

  def remove_product
    @cart.products.delete(@product)
    redirect_to cart_path(@cart), notice: 'Product removed from cart.'
  end

  def reset
    @cart.products.destroy_all
    redirect_to cart_path(@cart), notice: 'Cart cleared.'
  end

  def show; end

  private

  def check_user_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
