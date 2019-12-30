class PostsController < ApplicationController
  def index
  end

  def show
    @post = Post.find(params[:id])
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
    redirect_to current_user
  end

  def update
  end

  def delete
  end

  def edit
  end

  def likes
    @likes_users = Post.find(params[:id]).likes_users
    @number_of_likes = @likes_users.count
  end

  private
    def post_params
      params.require(:post).permit(:body)
    end
end
