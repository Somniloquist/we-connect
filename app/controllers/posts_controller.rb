class PostsController < ApplicationController
  def index
  end

  def show
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

  private
    def post_params
      params.require(:post).permit(:body)
    end
end
