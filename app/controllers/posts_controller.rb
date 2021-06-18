class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :edit, :update, :destroy, :search, :bookmarks]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tag_name].split(",")
    if @post.save
      @post.save_tag(tag_list)
      redirect_to post_path(@post), info: "投稿ありがとうございます"
    else
      render :new
    end
  end

  def index
    @posts = Post.all.order("created_at DESC").page(params[:page]).per(6)
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.order("created_at DESC")
    @post_tags = @post.tags
  end

  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.all.order("created_at DESC").page(params[:page]).per(6)
  end

  def bookmarks
    bookmarks = Bookmark.where(user_id: current_user.id).pluck(:post_id)  # ログイン中のユーザーのお気に入りのpost_idカラムを取得
    @bookmark_list = Post.find(bookmarks)
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tag_name).join(",")
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_name].split(",")
    if @post.update(post_params)
      @post.save_tag(tag_list)
      redirect_to post_path(@post), info: "投稿情報更新しました"
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, secondary: "投稿を削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:goods_name, :image, :caption, :rate)
  end
end