# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class CourseTest < ActiveSupport::TestCase
  setup do
    @course_attributes = courses(:course_one).attributes.except("id", "created_at", "updated_at")
  end

  test "valid course with title is valid" do
    course = Course.new(@course_attributes)
    assert course.valid?
  end

  test "invalid course without title (nil)" do
    course = Course.new(@course_attributes.merge(title: nil))
    assert_not course.valid?
  end

  test "invalid course with blank title" do
    course = Course.new(@course_attributes.merge(title: ""))
    assert_not course.valid?
  end
end
