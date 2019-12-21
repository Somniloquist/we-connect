require 'test_helper'

class StaticPagesTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
  end

  test "root path should show signup form when not signed in" do
    get root_path
    assert_template "static_pages/home"
    assert_select "form#new_user"
  end

  test "redirect to users profile when signed in" do
    sign_in @user
    get root_path
    follow_redirect!
    assert_template "users/show"
  end
end
