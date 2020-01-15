class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @banner_
    @date_joined = @user.created_at.strftime("%B %Y")
    @posts = @user.posts
    @number_of_friends = Friendship.joins(:user).where(user_id: @user, accepted?: true).count
  end

  def friends
    @user = User.find(params[:id])
    @friendships = Friendship.joins(:user).where(user_id: @user, accepted?: true)
    @friend_requests = @user.friend_requests
  end

  def edit
    @user = User.find(params[:id])
    create_thumbnail if @user.banner_picture.attached?
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Update successful."
      redirect_to @user
    else
      render :edit
    end
  end

  def delete_banner_picture
    @user = User.find(params[:id])
    if @user.banner_picture.attached?
      # Synchronously destroy the avatar and actual resource files.
      @user.banner_picture.purge
      flash[:success] = "Banner successfully removed."
    end
    render :edit
  end

  private
    def user_params
      params.require(:user).permit(:firstname, :lastname, :about, :banner_picture)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user == @user
    end

    def create_thumbnail
      # adds a thumbnail variant of the uploaded banner image if it doesn't already exist
      # https://edgeguides.rubyonrails.org/active_storage_overview.html#transforming-images
      @banner_thumb = @user.banner_picture.variant(combine_options: {
        auto_orient: true,
        gravity: "center",
        resize: "200^x100",
        crop: "200x100+0+0"
      })
    end
end
