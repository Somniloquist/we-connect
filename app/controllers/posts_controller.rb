class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.feed.paginate(page: params[:page], per_page: 20)
    @number_of_friends = Friendship.joins(:user).where(user_id: current_user, accepted?: true).count
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
    @post = Post.find(params[:id])
    if current_user == @post.user
      @post.delete
      flash[:success] = "Post deleted!"
    else
      flash[:warning] = "Oops, something went wrong."
    end
    redirect_back fallback_location: posts_path
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
