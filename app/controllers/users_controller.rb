class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @number_of_friends = Friendship.joins(:user).where(user_id: @user, accepted?: true).count
  end

  def friends
    @user = User.find(params[:id])
    @friendships = Friendship.joins(:user).where(user_id: @user, accepted?: true)
    @friend_requests = @user.friend_requests
  end
end
