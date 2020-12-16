class Contact < MailForm::Base
    attribute :name, validate: true
    attribute :email
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true
    attribute :message, validate: true
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
