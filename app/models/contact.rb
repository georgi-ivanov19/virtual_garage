class Contact < MailForm::Base
    attribute :name, validate: true
    attribute :email, validate: /\A[^@\s]+@[^@\s]+\z/i
    attribute :message
    attribute :hidden, captcha: true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
    def headers
    {
      subject: "Virtual Garage Contact Form",
      to: "virtualgaragee1@gmail.com",
      from: %("#{name}" <#{email}>)
    }
  end
end
