require "test_helper"

class UnitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @unit = units(:one)
    @user = users(:one)
  end

=begin
  test "should get accessibility" do
    get units_url
    assert_response :success
  end
=end

  test "should show unit" do
    sign_in @user
    get user_unit_url(@unit)
    assert_response :success
  end



  # assert_redirected_to user_units_url
end
