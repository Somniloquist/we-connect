require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "index when not signed in" do
    get users_path
    assert_redirected_to new_user_session_path
  end
end 
 