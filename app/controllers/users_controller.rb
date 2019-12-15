class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @number_of_friends = @user.friends.count
  end

  def friends
    @friends = User.find(params[:id]).friends
  end
end
