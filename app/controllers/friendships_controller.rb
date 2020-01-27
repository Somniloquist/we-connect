class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user ||= User.find(params[:user_id])
    current_user.add_friend(@user)
    respond_to do |format|
      format.html { redirect_back fallback_location: friends_user_path(@user) }
      format.js
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    # form still requires the user id
    @user = User.find(@friendship.user_id)
    @friendship.unfriend
    respond_to do |format|
      format.html { redirect_back fallback_location: friends_user_path(@user) }
      format.js
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @user = User.find(@friendship.user.id)
    @friendship.accept
    respond_to do |format|
      format.html { redirect_to friends_user_path(current_user)}
      format.js
    end
  end

end
