require 'test_helper'

class UserFriendshipsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:john)
    @other_user = users(:jane)
    sign_in(@user)
  end

  test "friend then unfriend a user" do
    # friend another user
    assert_difference "@other_user.friends.count", 1 do
      assert_difference "@user.friends.count", 1 do
        post friendships_path, params: { user_id: @other_user.id }
      end
    end
    follow_redirect!
    assert_select "li#friend-request-notification", 0
    # unfriend the user
    friendship = @user.friendships.find_by(friend_id: @other_user.id)
    assert_difference "@other_user.friends.count", -1 do
      assert_difference "@user.friends.count", -1 do
        delete friendship_path(friendship)
      end
    end
    follow_redirect!
    assert_select "li#friend-request-notification", 0
  end

  test "friend then unfriend a user with ajax" do
    # friend another user
    assert_difference "@other_user.friends.count", 1 do
      assert_difference "@user.friends.count", 1 do
        post friendships_path, xhr: true, params: { user_id: @other_user.id }
      end
    end
    # unfriend the user
    friendship = @user.friendships.find_by(friend_id: @other_user.id)
    assert_difference "@other_user.friends.count", -1 do
      assert_difference "@user.friends.count", -1 do
        delete friendship_path(friendship), xhr: true
      end
    end
  end

end
