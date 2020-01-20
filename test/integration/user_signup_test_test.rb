require 'test_helper'

class UserSignupTestTest < ActionDispatch::IntegrationTest

  test "Submitting invalid information should not create a new user" do
    get new_user_registration_path
    assert_select "form[action='/users']"
    assert_no_difference "User.count" do
      post user_registration_path, params: { user: {  firstname:  "",
                                                          lastname:   "    ",
                                                          email: "",
                                                          password: "hunter1",
                                                          password_confirmation: "hunter2",
                                                          birthday: "",
                                                          gender: "" } }
    end
    assert_template "devise/registrations/new"
    assert_select "div#error_explanation>ul>li", 4
  end

  test "Submitting valid information should create a new user" do
    get new_user_registration_path
    assert_select "form[action='/users']"
    assert_difference "User.count", 1 do
      post user_registration_path, params: { user: {  firstname: "Artoria",
                                                          lastname: "Pendragon",
                                                          email: "borgor@example.com",
                                                          password: "foobar",
                                                          password_confirmation: "foobar",
                                                          birthday: Time.now,
                                                          gender: "male" } }
    end
  end

end
