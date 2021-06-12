class BookmarksController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    if @post.user_id != current_user.id
      @post.bookmark(current_user)
    end
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @post.unbookmark(current_user)
    redirect_back(fallback_location: root_path)
  end
  
end
