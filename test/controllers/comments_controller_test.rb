require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @post = posts(:orange)
  end

  test "create should require a logged in user" do
    assert_no_difference "Comment.count" do
      post post_comments_path(@post)
    end
    assert_redirected_to new_user_session_path
  end

end
