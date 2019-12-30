require 'test_helper'

class LikesTest < ActionDispatch::IntegrationTest
  include ActionView::Helpers::TextHelper

  def setup
    @user = users(:john)
    @post = posts(:orange)
    sign_in(@user)
  end

  test "post likes page shows correctly" do
    get likes_post_path(@post)
    assert_not @post.likes.empty?
    assert_not @post.likes_users.empty?
    @post.likes_users.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end

  test "liking a post updates the like count" do 
    get post_path(@post)
    likes = @post.likes.count
    assert_match "#{pluralize(likes, 'like')}", response.body
    post likes_path, params: { post_id: @post.id, user_id: @user.id }
    follow_redirect!
    assert_template "posts/show"
    assert_match "#{pluralize(likes + 1, 'like')}", response.body
  end
end
