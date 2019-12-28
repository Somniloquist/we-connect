require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  test "create should require a logged in user" do
    assert_no_difference "Like.count" do
      post likes_path
    end
    assert_redirected_to new_user_session_url
  end

  test "destroy should require a logged in user" do
    assert_no_difference "Like.count" do
      delete like_path(likes(:one))
    end
    assert_redirected_to new_user_session_url
  end
end
