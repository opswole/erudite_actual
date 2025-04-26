require "test_helper"

class CourseOwnershipTest < ActiveSupport::TestCase
  setup do
    @course_ownership_attributes = course_ownerships(:course_ownership_one).attributes.except("id", "created_at", "updated_at")
  end

  test "valid course ownership with course and user is valid" do
    course_ownership = CourseOwnership.new(@course_ownership_attributes)
    assert course_ownership.valid?
  end

  test "invalid course ownership without course" do
    course_ownership = CourseOwnership.new(@course_ownership_attributes.merge(course_id: nil))
    assert_not course_ownership.valid?
  end

  test "invalid course ownership without user" do
    course_ownership = CourseOwnership.new(@course_ownership_attributes.merge(user_id: nil))
    assert_not course_ownership.valid?
  end

  test "invalid course ownership with student user" do
    course_ownership = CourseOwnership.new(@course_ownership_attributes.merge(user_id: users(:student).id))
    assert_not course_ownership.valid?
  end
end
