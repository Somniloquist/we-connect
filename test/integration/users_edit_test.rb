require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
    @other_user = users(:jane)
    sign_in(@user)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template("users/edit")
    patch user_path(@user), params: { user: { firstname: "",
                                              lastname: " ",
                                              about: "meh" } }
    assert_template "users/edit"
    assert_select "div#error_explanation>ul>li", 2
  end

  test "successful edit" do
    get edit_user_path(@user)
    assert_template("users/edit")
    firstname = "Foo"
    lastname = "Bar"
    about = "I am FooBar"
    patch user_path(@user), params: { user: { firstname: firstname,
                                              lastname: lastname,
                                              about: about } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal firstname, @user.firstname
    assert_equal lastname, @user.lastname
    assert_equal about, @user.about
  end

  test "cannot edit other user profiles" do
    get edit_user_path(@other_user)
    assert_redirected_to root_path
    patch user_path(@other_user), params: { user: { firstname: "invalid",
                                                    lastname: "profile",
                                                    about: "you can't do that" } }
    assert_redirected_to root_path
  end
end
