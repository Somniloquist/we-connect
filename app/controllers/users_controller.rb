class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @friendship = Friendship.find_by(user_id: current_user.id, friend_id: @user.id)
  end
end
