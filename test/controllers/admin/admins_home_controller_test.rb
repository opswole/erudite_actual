require "test_helper"

class Admin::AdminsHomeControllerTest < ActionDispatch::IntegrationTest
  test "Admin home inaccessible without login" do
    get admin_root_path
    assert_redirected_to new_session_url
  end
end
