class NotifierMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier_mailer.order_received.subject
  #
  default :from => "HotelsChristmas <HotelsChristmas@gmail.com>"
  def order_received(order)
    @user = order

    mail :to => @user.email, :subject => "Thanks for your order"
  end
end
