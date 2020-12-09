class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?

    #protect the database, while allowing these fields to be updated
    protected
    def configure_permitted_parameters        
        devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end
end
