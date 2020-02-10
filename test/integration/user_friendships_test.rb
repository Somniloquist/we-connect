require 'test_helper'

class UserFriendshipsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:john)
    @other_user = users(:jane)
    sign_in(@user)
  end

  test "friend/unfriend button updates when clicked" do
    get user_path(@other_user)
    assert_template "users/show"
    assert_select "form#add-friend-form"
    post friendships_path, params: { user_id: @other_user.id }
    get user_path(@other_user)
    assert_select "form#remove-friend-form"
  end
  
  test "friend then unfriend a user" do
    # friend another user
    get users_path
    assert_difference "@other_user.friends.count", 1 do
      assert_difference "@user.friends.count", 1 do
        post friendships_path, params: { user_id: @other_user.id }
      end
    end
    follow_redirect!

    # ensure friend request count is correct for both users then accept friend request
    assert_select "li#friend-request-notification", 0
    sign_out @user
    sign_in @other_user
    get friends_user_path(@other_user)
    assert_select "li#friend-request-notification", 1
    # friends name and email shows up correctly
    assert_match "#{@user.firstname} #{@user.lastname}", response.body
    patch friendship_path(@other_user.friend_requests.last.id)
    assert_select "li#friend-request-notification", 0
    sign_out @other_user


    # unfriend the user
    sign_in @user
    friendship = @user.friendships.find_by(friend_id: @other_user.id)
    assert_difference "@other_user.friends.count", -1 do
      assert_difference "@user.friends.count", -1 do
        delete friendship_path(friendship)
      end
    end
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
