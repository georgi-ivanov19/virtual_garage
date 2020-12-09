class UserMailer < ApplicationMailer
    def notify_user(user)
        @user = user
        mail(to: @user.email, subject: 'Virtual Garage Sign up Confirmation')
    end
end
