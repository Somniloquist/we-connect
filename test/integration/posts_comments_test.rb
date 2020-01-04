require 'test_helper'

class PostsCommentsTest < ActionDispatch::IntegrationTest
  include ActionView::Helpers::TextHelper

  def setup
    @user = users(:john)
    @post = posts(:orange)
    sign_in(@user)
  end

  test "comment on a post, then comment on a comment" do
    get post_path(@post)
    assert_template "posts/show"
    post_comment_body = "This is some unique comment body text"
    assert_difference "Comment.count", 1 do
      post post_comments_path(@post), params: { comment: { body: post_comment_body } } 
    end
    @post.reload
    follow_redirect!
    assert_not flash.empty?
    assert_match post_comment_body, response.body
    assert @post.comments_count == 1
    assert_match pluralize(@post.comments_count, "comment"), response.body
    # Comment on the newly created comment
    post_comment = Comment.find_by(body: post_comment_body)
    comment_comment_body = "This is yet another unique comment body text"
    assert_difference "Comment.count", 1 do
      post comment_comments_path(post_comment), params: { comment: { body: comment_comment_body } } 
    end
    @post.reload
    follow_redirect!
    assert_match comment_comment_body, response.body
    assert @post.comments_count == 2
    assert_match pluralize(@post.comments_count, "comment"), response.body
  end

end
