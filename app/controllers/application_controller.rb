class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def check_guest
    if current_user.email == 'guest@test.com'
      redirect_to user_path(current_user), alert: 'ゲストユーザーの編集・退会はできません。'
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
