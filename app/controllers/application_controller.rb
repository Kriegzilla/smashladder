class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    users_path
  end

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  protected

  def configure_permitted_parameters
   devise_parameter_sanitizer.for(:sign_up) << [:username, :crew_tag]
   devise_parameter_sanitizer.for(:account_update) << [
     :username,
     :avatar,
     :crew_tag,
     :character_id
   ]
  end
end
