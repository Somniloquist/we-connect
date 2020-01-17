require 'test_helper'

class UsersPostsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users :john
    sign_in @user
  end

  test "should create a new post" do
    get user_path @user
    posts = @user.posts.count
    assert_select "div.post-card", posts
    file = fixture_file_upload(Rails.root.join("public", "apple-touch-icon.png"), "image/png")
    assert_difference "Post.count", 1 do
      post posts_path, params: { post: { body: "this is a test", image: file} }
    end
    follow_redirect!
    assert_match file.original_filename, response.body
    assert_template "posts/index"
    assert_select "div.post-card", posts + 1
  end
end
