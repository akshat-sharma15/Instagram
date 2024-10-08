class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :picture, :bio])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :picture, :bio])
  end
end
