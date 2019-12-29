require 'test_helper'

class LikesTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
    @post = posts(:apple)
  end

  test "likes page" do
    get likes_post_path(@post)
    assert_not @post.likes.empty?
    assert_not @post.likes_users.empty?
    @post.likes_users.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end
end
