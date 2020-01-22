require 'test_helper'

class UsersDeleteTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:john)
    @user_id = @user.id
  end

  test "should require a signed_in user" do
    assert_no_difference "User.count" do
      delete user_registration_path
     end
  end
  
  test "should delete a user" do
    sign_in(@user)
    assert_difference "User.count", -1 do
     delete user_registration_path
    end
    # deletes users friendships
    assert Friendship.where(user_id: @user_id).empty? && Friendship.where(friend_id: @user_id).empty?
    # deletes user's posts
    assert Post.where(user_id: @user_id).empty?
    # deletes user's comments
    assert Comment.where(user_id: @user_id).empty?
    # deletes user's likes
    assert Like.where(user_id: @user_id).empty?

    follow_redirect!
    assert_template("static_pages/home")
  end

end
