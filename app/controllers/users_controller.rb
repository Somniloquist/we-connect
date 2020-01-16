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
    @user = User.find(params[:user_id])
    create_banner_thumbnail if @user.banner_picture.attached?
    create_avatar_thumbnail if @user.avatar.attached?
  end

  def update
    @user = User.find(params[:user_id])
    if @user.update_attributes(user_params)
      flash[:success] = "Update successful."
    end
    render :edit
  end

  def delete_banner_picture
    @user = User.find(params[:id])
    if @user.banner_picture.attached?
      # Synchronously destroy the avatar and actual resource files.
      @user.banner_picture.purge
      flash[:success] = "Banner successfully removed."
    end
    redirect_to user_settings_path(@user)
  end

  def delete_avatar
    @user = User.find(params[:id])
    if @user.avatar.attached?
      # Synchronously destroy the avatar and actual resource files.
      @user.avatar.purge
      flash[:success] = "Avatar successfully removed."
    end
    redirect_to user_settings_path(@user)
  end

  private
    def user_params
      params.require(:user).permit(:firstname, :lastname, :about, :banner_picture, :avatar)
    end

    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_path) unless current_user == @user
    end

    def create_avatar_thumbnail
      @avatar_thumb = @user.avatar.variant(combine_options: {
        auto_orient: true,
        gravity: "center",
        resize: "100^x100",
        crop: "100x100+0+0"
      })
    end

    def create_banner_thumbnail
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
