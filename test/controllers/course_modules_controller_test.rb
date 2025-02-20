require "test_helper"

class CourseModulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course_module = course_modules(:one)
  end

  test "should get index" do
    get course_modules_url
    assert_response :success
  end

  test "should get new" do
    get new_course_module_url
    assert_response :success
  end

  test "should create course_module" do
    assert_difference("CourseModule.count") do
      post course_modules_url, params: { course_module: { course_id: @course_module.course_id, description: @course_module.description, title: @course_module.title } }
    end

    assert_redirected_to course_module_url(CourseModule.last)
  end

  test "should show course_module" do
    get course_module_url(@course_module)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_module_url(@course_module)
    assert_response :success
  end

  test "should update course_module" do
    patch course_module_url(@course_module), params: { course_module: { course_id: @course_module.course_id, description: @course_module.description, title: @course_module.title } }
    assert_redirected_to course_module_url(@course_module)
  end

  test "should destroy course_module" do
    assert_difference("CourseModule.count", -1) do
      delete course_module_url(@course_module)
    end

    assert_redirected_to course_modules_url
  end
end
