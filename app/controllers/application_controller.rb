class ApplicationController < ActionController::Base

  def after_sign_up_path_for(resource)
    appeals_path
  end

  def after_sign_in_path_for(resource)
    appeals_path
  end

  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :verification_mail

  protected

    # def verification_mail
    #   UserMailer.welcome_email.deliver_now
    # end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :username, :name, :profile_image])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email_or_username])
    end

end
