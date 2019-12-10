require 'test_helper'

class UserFriendshipsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:john)
    @other_user = users(:jane)
    sign_in(@user)
  end

  test "creates a mutual friendship" do
    assert_difference "@other_user.friends.count", 1 do
      assert_difference "@user.friends.count", 1 do
        post user_friendships_path(@other_user), params: { user_id: @other_user.id }
      end
    end
  end

end
