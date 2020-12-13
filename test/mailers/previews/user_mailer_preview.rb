# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def notify_user
        UserMailer.notify_user(User.first)
    end
end
