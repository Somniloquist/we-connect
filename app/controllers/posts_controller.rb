class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @feed = current_user.feed
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
    else
      flash[:warning] = "Post can't be empty."
    end
    redirect_to posts_path
  end

  def update
  end

  def destroy
  end

  def edit
  end

  def likes
    @likes_users = Post.find(params[:id]).likes_users
    @number_of_likes = @likes_users.count
  end

  private
    def post_params
      params.require(:post).permit(:body, :image)
    end
end
