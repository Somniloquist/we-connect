require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:john)
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "frstname should be present" do
    @user.firstname = "      "
    assert_not @user.valid?
  end

  test "lastname should be present" do
    @user.lastname = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end
  
  test "about should be optional" do
    @user.about = "       "
    assert @user.valid?
  end

  test "about should be 255 characters or less" do
    @user.about = "a" * 256
    assert_not @user.valid?
  end
end
