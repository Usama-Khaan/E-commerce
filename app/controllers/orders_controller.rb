class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
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

  private

  def order_params
    params.require(:order).permit(:id, :email, :city, :country, :first_name, :last_name, :address, :postal_code, :phone_number)
  end
end
