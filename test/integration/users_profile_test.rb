require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest

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
end
