class FriendshipsController < ApplicationController
  def index
  end

  def new
  end

  def create
    other_user = User.find(params[:user_id])
    if current_user.add_friend(other_user)
      flash[:success] = "You are now friends."
    else
      flash[:warning] = "Something went wrong."
    end
    redirect_to other_user
  end

  def destroy
    other_user = User.find(params[:user_id])
    current_user.remove_friend(other_user)
    flash.now[:success] = "Friend removed."
  end
end
