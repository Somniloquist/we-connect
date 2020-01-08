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
    @user = Friendship.find(params[:id]).friend
    current_user.remove_friend(@user)
    respond_to do |format|
      format.html { redirect_back fallback_location: friends_user_path(@user) }
      format.js
    end
  end

  def update
    @friendship = Friendship.find(params[:friendship_id])
    @friendship.accept
    respond_to do |format|
      format.html { redirect_to friends_user_path(current_user)}
      format.js
    end
  end

end
