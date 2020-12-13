class UserMailer < ApplicationMailer
    def notify_user(user)
        @user = user
        mail(to: @user.email, subject: 'Virtual Garage Sign up Confirmation')
    end

    def user_edited(user)
        @user = user
        mail(to: @user.email, subject: 'Your Virtual Garage password has been changed')
    end
end
