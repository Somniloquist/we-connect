require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:john)
  end

  test "should get new" do
    get new_user_registration_path
    assert_response :success
  end

  test "update/delete attach then remove a banner" do
    sign_in(@user)
    file = fixture_file_upload(Rails.root.join("public", "apple-touch-icon.png"), "image/png")
    assert_difference "ActiveStorage::Attachment.count", 1 do
      patch user_settings_path(@user), params: { user: { banner_picture: file } }
    end
    assert_difference "ActiveStorage::Attachment.count", -1 do
      delete delete_banner_user_path(@user)
    end
  end

  test "update/delete attach then remove a avatar" do
    sign_in(@user)
    file = fixture_file_upload(Rails.root.join("public", "apple-touch-icon.png"), "image/png")
    assert_difference "ActiveStorage::Attachment.count", 1 do
      patch user_settings_path(@user), params: { user: { avatar: file } }
    end
    assert_difference "ActiveStorage::Attachment.count", -1 do
      delete delete_avatar_user_path(@user)
    end
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { firstname: @user.firstname,
                                              lastname: @user.lastname,
                                              about: @user.about } }
    assert_not flash.empty?
    assert_redirected_to new_user_session_path
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to new_user_session_path
  end
end
