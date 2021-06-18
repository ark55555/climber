class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :check_guest, only: [:update, :destroy]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all.order("created_at DESC").page(params[:page]).per(6)
  end

  def following
    user = User.find(params[:id])
		@users = user.following
  end

  def followers
    user = User.find(params[:id])
		@users = user.followers
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), info: "ユーザー情報を編集しました!"
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if @user.destroy
      redirect_to root_path, info: "アカウントを削除しました。またのご利用を心よりお待ちしております"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
      flash[:warning] = '自分のユーザー情報以外は変更することができません'
    end
  end

end