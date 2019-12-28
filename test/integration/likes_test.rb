require 'test_helper'

class LikesTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
    @post = posts(:apple)
  end

  test "liking a post" do
    
  end
end
