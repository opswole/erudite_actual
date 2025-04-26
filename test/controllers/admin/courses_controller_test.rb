require "test_helper"

class Admin::CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @student = users(:student)
    @course = courses(:course_one)
    sign_in_as(@admin)
  end

  test "GET index renders successfully for admin" do
    get admin_courses_path
    assert_response :success
    assert_select "h1", "Course Overview:"
  end

  test "GET index redirects for non-admin" do
    sign_in_as(@student)
    get admin_courses_path
    assert_redirected_to root_path
  end

  test "GET show renders successfully for admin" do
    get admin_course_path(@course)
    assert_response :success
    assert_select "h1", text: /#{@course.title}/
  end

  test "GET show redirects for non-admin" do
    sign_in_as(@student)
    get admin_course_path(@course)
    assert_redirected_to root_path
  end

  test "GET new renders successfully for admin" do
    get new_admin_course_path
    assert_response :success
    assert_select "form"
  end

  test "GET new redirects for non-admin" do
    sign_in_as(@student)
    get new_admin_course_path
    assert_redirected_to root_path
  end

  test "POST create with valid params creates course and redirects" do
    assert_difference "Course.count", 1 do
      post admin_courses_path, params: {
        course: {
          title: "New Course",
          course_ownerships_attributes: [ { user_id: @admin.id } ]
        }
      }
    end
    assert_redirected_to admin_course_path(Course.last)
    assert_equal "Course created successfully", flash[:notice]
  end

  test "POST create with invalid params renders new" do
    assert_no_difference "Course.count" do
      post admin_courses_path, params: { course: { title: "" } }
    end
    assert_response :unprocessable_entity
    assert_select "form"
  end

  test "POST create redirects for non-admin" do
    sign_in_as(@student)
    post admin_courses_path, params: { course: { title: "New Course" } }
    assert_redirected_to root_path
  end

  test "GET edit renders successfully for admin" do
    get edit_admin_course_path(@course)
    assert_response :success
    assert_select "form"
  end

  test "GET edit redirects for non-admin" do
    sign_in_as(@student)
    get edit_admin_course_path(@course)
    assert_redirected_to root_path
  end

  test "PATCH update with valid params updates course and redirects" do
    patch admin_course_path(@course), params: { course: { title: "Updated Course" } }
    assert_redirected_to admin_course_path(@course)
    assert_equal "Course updated successfully", flash[:notice]
    assert_equal "Updated Course", @course.reload.title
  end

  test "PATCH update with invalid params renders edit" do
    patch admin_course_path(@course), params: { course: { title: "" } }
    assert_response :unprocessable_entity
    assert_select "form"
  end

  test "PATCH update redirects for non-admin" do
    sign_in_as(@student)
    patch admin_course_path(@course), params: { course: { title: "Updated Course" } }
    assert_redirected_to root_path
  end

  test "DELETE destroy removes course and redirects" do
    assert_difference "Course.count", -1 do
      delete admin_course_path(@course)
    end
    assert_redirected_to admin_courses_path
    assert_equal "Course deleted successfully", flash[:notice]
  end

  test "DELETE destroy redirects for non-admin" do
    sign_in_as(@student)
    delete admin_course_path(@course)
    assert_redirected_to root_path
  end

  private

  def sign_in_as(user)
    post session_url, params: { email_address: user.email_address, password: "password" }
    follow_redirect!
  end
end
