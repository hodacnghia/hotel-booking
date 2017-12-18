class ExampleMailer < ApplicationMailer
  default from: "niemanvui221296@gmail.com"

   def sample_email user
     @user = user
     mail to: @user.email, subject: "Sample email"

   end
end
