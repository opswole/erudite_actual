require "test_helper"

class Admin::AdminsHomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student =  users(:student)
    @teacher = users(:teacher)
    @admin = users(:admin)
  end
  test "Admin home inaccessible without login" do
    get admin_root_path
    assert_redirected_to new_session_url
  end

  test "Admin home inaccessible with student login" do
    sign_in(@student)
    get admin_root_path

    assert_redirected_to root_url
  end
  test "Admin home inaccessible with teacher login" do
    sign_in(@teacher)
    get admin_root_path

    assert_redirected_to root_url
  end

  test "Admin home accessible with admin login" do
    sign_in(@admin)
    get admin_root_path
    assert_response :success
  end

  private
  def sign_in(user)
    post session_url, params: { email_address: user.email_address, password: "password" }
  end
end
