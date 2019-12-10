class FriendshipsController < ApplicationController
  def index
  end

  def create
    other_user = User.find(params[:user_id])
    current_user.add_friend(other_user)
    respond_to do |format|
      format.html { redirect_to other_user }
    end
  end

  def destroy
    other_user = User.find(params[:user_id])
    current_user.remove_friend(other_user)
    respond_to do |format|
      format.html { redirect_to other_user }
    end
  end
end
