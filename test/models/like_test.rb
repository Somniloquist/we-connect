require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @like = Like.new(user_id: users(:john).id,
                      post_id: posts(:apple).id)
  end

  test "should be valid" do
    assert @like.valid?
  end

  test "should require a user_id" do
    @like.user_id = nil
    assert_not @like.valid?
  end

  test "should require a post_id" do
    @like.post_id = nil
    assert_not @like.valid?
  end
end
