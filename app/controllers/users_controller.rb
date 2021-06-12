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