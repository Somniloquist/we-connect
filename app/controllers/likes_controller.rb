class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    current_user.like(@post)
    redirect_back fallback_location: post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    current_user.unlike(@post)
    redirect_back fallback_location: post_path(@post)
  end
end
