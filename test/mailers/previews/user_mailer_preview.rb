<<<<<<< HEAD
# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def notify_user
        UserMailer.notify_user(User.first)
    end

    def user_edited
        UserMailer.user_edited(User.first)
    end

    def account_deleted
        UserMailer.account_deleted(User.first)
    end

end
=======
# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def notify_user
        UserMailer.notify_user(User.first)
    end
end
>>>>>>> 8e7df3715d29d641d54c31fe62dfdcbea066054c
