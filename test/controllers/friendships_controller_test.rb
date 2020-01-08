require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:john)
  end

  test "create should require a logged in user" do
    assert_no_difference "Friendship.count" do
      post friendships_path
    end
  end

  test "destroy should require a logged in user" do
    assert_no_difference "Friendship.count" do
      delete friendship_path(@user)
    end
  end

  test "update should require a logged in user" do
    assert_no_difference "Friendship.count" do
      patch friendship_path(@user)
    end
  end

end
