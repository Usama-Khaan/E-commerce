class OrdersController < ApplicationController
  before_action :find_order_id, only: %i[show complete update]

  def update
    if @order.update(order_params)
      flash[:notice] = 'Order status updated successfully.'
      OrderNotifierMailer.order_status_notification(@order, @order.status).deliver_now
    else
      flash[:alert] = 'Failed to update order status.'
    end
    redirect_to user_path(@order.user)
  end

  def new
    @order = Order.new
  end

  def create
    @cart = current_user.cart
    @order = current_user.orders.build(order_params)
    @order.cart = @cart
    if @order.save
      redirect_to order_path(@order)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

def complete
  OrderNotifierMailer.new_order(current_user, @order).deliver_now
  @cart = @order.cart
  if @cart
    @cart.line_items.each do |line_item|
      product = line_item.product
      product.reduce_stock_quantity(line_item.line_items_quantity)
    end
    @cart.line_items.destroy_all
    flash[:notice] = "Thanks for ordering our products"
  else
    flash[:alert] = "Cart not found."
  end
  redirect_to products_path
end

  private

  def find_order_id
    @order = Order.find_by(id: params[:id])
  end

  def order_params
    params.require(:order).permit(:status, :id, :email, :city, :country, :first_name, :last_name, :address, :postal_code, :phone_number)
  end
end
