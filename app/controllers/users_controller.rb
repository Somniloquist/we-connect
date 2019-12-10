class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @friendship = Friendship.where(user_id: current_user.id, friend_id: params[:user_id])
    @user = User.find(params[:id])
  end
end
