require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
  end

  test "should get home_index" do
    sign_in(@user)
    get root_url
    assert_response :success
  end


  private
  def sign_in(user)
    post session_url, params: { email_address: user.email_address, password: "password" }
  end
end
