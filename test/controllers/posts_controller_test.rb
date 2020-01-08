require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @post = posts(:orange)
  end

  test "index should require logged in user" do
    get posts_path
    assert_redirected_to new_user_session_path
  end

  test "create should require a logged in user" do
    assert_no_difference "Post.count" do
      post posts_path
    end
  end

  test "new should require a logged in user" do
    get new_post_path
    assert_redirected_to new_user_session_path
  end

  test "edit should require a logged in user" do
    get edit_post_path(@post)
    assert_redirected_to new_user_session_path
  end

  test "show should require a logged in user" do
    get post_path(@post)
    assert_redirected_to new_user_session_path
  end

  test "update should require a logged in user" do
    assert_no_difference "Post.count" do
      patch post_path(@post)
    end
  end

  test "destroy should require a logged in user" do
    assert_no_difference "Post.count" do
      delete post_path(@post)
    end
  end

  test "likes should require a logged in user" do
    get likes_post_path(@post)
    assert_redirected_to new_user_session_path
  end

end
