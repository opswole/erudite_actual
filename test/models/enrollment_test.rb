require "test_helper"

class EnrollmentTest < ActiveSupport::TestCase
  setup do
    @enrollment_attributes = enrollments(:enrollment_one).attributes.except("id", "created_at", "updated_at")
    users(:student).enrollment.destroy!
  end

  test "valid enrollment with user and course is valid" do
    enrollment = Enrollment.new(@enrollment_attributes)
    assert enrollment.valid?
  end

  test "invalid enrollment without user" do
    enrollment = Enrollment.new(@enrollment_attributes.merge(user_id: nil))
    assert_not enrollment.valid?
  end

  test "invalid enrollment without course" do
    enrollment = Enrollment.new(@enrollment_attributes.merge(course_id: nil))
    assert_not enrollment.valid?
  end

  test "invalid enrollment with duplicate user" do
    enrollment = Enrollment.new(@enrollment_attributes.merge(user_id: users(:student).id))
    assert_not enrollment.valid?
  end
end
