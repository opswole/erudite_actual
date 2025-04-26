# == Schema Information
#
# Table name: units
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  course_id   :integer          not null
#
# Indexes
#
#  index_units_on_course_id  (course_id)
#

require "test_helper"

class UnitTest < ActiveSupport::TestCase
  setup do
    @unit_attributes = units(:unit_one).attributes.except("id", "created_at", "updated_at")
  end

  test "valid unit is valid" do
    unit = Unit.new(@unit_attributes)
    assert unit.valid?
  end

  test "invalid unit with nil title" do
    unit = Unit.new(@unit_attributes.merge(title: nil))
    assert_not unit.valid?
  end

  test "invalid unit with blank title" do
    unit = Unit.new(@unit_attributes.merge(title: ""))
    assert_not unit.valid?
  end

  test "invalid unit with nil description" do
    unit = Unit.new(@unit_attributes.merge(description: nil))
    assert_not unit.valid?
  end

  test "invalid unit with blank description" do
    unit = Unit.new(@unit_attributes.merge(description: ""))
    assert_not unit.valid?
  end

  test "invalid unit with nil course" do
    unit = Unit.new(@unit_attributes.merge(course_id: nil))
    assert_not unit.valid?
  end
end
