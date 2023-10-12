class OrderNotifierMailer < ApplicationMailer
  def new_order(user, order)
    @user = user
    @order = order
    mail(
      to: user.email,
      subject: "New purchase details"
    )
  end
end
