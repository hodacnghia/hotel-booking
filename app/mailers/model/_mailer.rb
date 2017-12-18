class _mailer < ApplicationMailer
  default from: "me@MYDOMAIN.com"
  def new_record_notification(record)
  @record = record
  mail to: "recipient@MYDOMAIN.com", subject: "Success! You did it."
end
end
