require "application_system_test_case"

class CourseModulesTest < ApplicationSystemTestCase
  setup do
    @course_module = course_modules(:one)
  end

  test "visiting the accessibility" do
    visit course_modules_url
    assert_selector "h1", text: "Course modules"
  end

  test "should create courses module" do
    visit course_modules_url
    click_on "New courses module"

    fill_in "Course", with: @course_module.course_id
    fill_in "Description", with: @course_module.description
    fill_in "Title", with: @course_module.title
    click_on "Create Course module"

    assert_text "Course module was successfully created"
    click_on "Back"
  end

  test "should update Course module" do
    visit course_module_url(@course_module)
    click_on "Edit this courses module", match: :first

    fill_in "Course", with: @course_module.course_id
    fill_in "Description", with: @course_module.description
    fill_in "Title", with: @course_module.title
    click_on "Update Course module"

    assert_text "Course module was successfully updated"
    click_on "Back"
  end

  test "should destroy Course module" do
    visit course_module_url(@course_module)
    click_on "Destroy this courses module", match: :first

    assert_text "Course module was successfully destroyed"
  end
end
