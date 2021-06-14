class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all.page(params[:page]).per(6)
  end

  def bookmark
    bookmarks = Bookmark.where(user_id: current_user.id).pluck(:post_id)  # ログイン中のユーザーのお気に入りのpost_idカラムを取得
    @bookmark_list = Post.find(bookmarks)
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
      redirect_to user_path(@user), notice: "ユーザー情報を編集しました!"
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if @user.destroy
      redirect_to root_path, notice: "アカウントを削除しました。またのご利用を心よりお待ちしております"
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