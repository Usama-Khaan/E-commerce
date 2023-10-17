class OrderNotifierMailer < ApplicationMailer
  def new_order(user, order)
    @user = user
    @order = order
    mail(
      to: user.email,
      subject: "New purchase details"
    )
  end

  def order_status_notification(order, status)
    @order = order
    @status = status
    mail(to: order.user.email)
  end
end
