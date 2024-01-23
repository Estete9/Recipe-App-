class ApplicationController < ActionController::Base
  before_action :configure_account_params, if: :devise_controller?

  private

  def configure_account_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email password])
  end
end
