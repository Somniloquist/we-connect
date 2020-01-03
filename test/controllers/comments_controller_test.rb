require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_comment_path
    assert_response :success
  end

end
