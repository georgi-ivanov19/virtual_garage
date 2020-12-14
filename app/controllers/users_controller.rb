class UsersController < Devise::RegistrationsController
    #controller ised to define methods that check if email and username are already in the db (taken)
    def check_email
        @user = User.find_by_email(params[:user][:email])

        respond_to do |format|
        format.json { render :json => !@user }
        end
    end

    def check_username
        @user = User.find_by_username(params[:user][:username])

        respond_to do |format|
        format.json { render :json => !@user }
        end
    end

    def user_params
        params.require(:user).permit(:email, :username, :encrypted_password)
    end
end