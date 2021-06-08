class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def show 
    @user = User.find(params[:id])
    @posts = @user.posts.all.page(params[:page]).per(6)
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
  end
  
  def confirm
  end

  def retire
  end
  
  private
  
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  
end
