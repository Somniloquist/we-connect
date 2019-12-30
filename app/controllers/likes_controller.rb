class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    current_user.like(@post)
    respond_to do |format|
      format.html { redirect_back fallback_location: post_path(@post) }
      format.js
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = Like.find(params[:id])
    current_user.unlike(like)
    respond_to do |format|
      format.html { redirect_back fallback_location: post_path(@post) }
      format.js
    end
  end
end
