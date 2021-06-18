class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :secondary, :danger
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後マイページへ遷移
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end
  
  # 管理者かどうかの確認
  def admin_user
    unless current_user.admin?
      redirect_to root_path, danger: '管理者以外はアクセスできません'
    end
  end

  # ゲストユーザー
  def check_guest
    if current_user.email == 'guest@test.com'
      redirect_to user_path(current_user), danger: 'ゲストユーザーは操作できません。'
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name])
  end
end
