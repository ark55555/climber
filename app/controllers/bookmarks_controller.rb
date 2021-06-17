class BookmarksController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post.bookmark(current_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post.unbookmark(current_user)
  end

end
