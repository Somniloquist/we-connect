require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:john)
    @post = posts(:orange)
    @comment = @post.comments.new(user: @user, body: "Test comment.")
  end

  test "valid comment" do
    assert @comment.valid?
  end

  test "user id should be present" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test "body should be present" do
    @comment.body = "    "
    assert_not @comment.valid?
  end
end
