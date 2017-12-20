class OrderMailer < ActionMailer::Base
  def order_created(user)
    mail(to: user.email,
          from: "team1@gmail.com",
          subject: "Order created",
          body: "Thank you for your order!"
        )
  end

end
