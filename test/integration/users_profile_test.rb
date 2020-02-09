require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ActionView::Helpers::TextHelper

  def setup
    @user = users(:john)
    sign_in(@user)
  end
  
  test "profile display's correctly" do
    get user_path(@user)
    assert_template "users/show"
    assert_select "h1", text: @user.fullname
    assert_select "div#profile-avatar>img.avatar"
    assert_match pluralize(@user.friends.count, "friend").to_s, response.body
    @user.posts.each do |post|
      assert_match post.body, response.body
    end
  end
end
