require 'test_helper'

class PostsCommentsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:john)
    @post = posts(:orange)
    sign_in(@user)
  end

  test "creates a new comment on a post" do
    get post_path(@post)
    assert_template "posts/show"
    comment_body = "This is some unique comment body text"
    assert_difference "Comment.count", 1 do
      post post_comments_path(@post), params: { comment: { body: comment_body } } 
    end
    follow_redirect!
    assert_not flash.empty?
    assert_match comment_body, response.body
  end

end
