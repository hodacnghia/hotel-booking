class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
  def sample_email users
    @user=user
    mail to: @user.email, subject: "Sample Email"
  end
end
