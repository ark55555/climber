class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @post.bookmark(current_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post.unbookmark(current_user)
  end

end
