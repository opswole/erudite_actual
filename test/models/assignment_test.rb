# == Schema Information
#
# Table name: assignments
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  deadline    :datetime
#  unit_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_assignments_on_unit_id  (unit_id)
#

require "test_helper"

class AssignmentTest < ActiveSupport::TestCase
  setup do
    @assignment_attributes = assignments(:assignment_one).attributes.except("id", "created_at", "updated_at")
  end

  test "valid assignment with unit is valid" do
    assignment = Assignment.new(@assignment_attributes)
    assert assignment.valid?
  end

  test "invalid assignment without unit" do
    assignment = Assignment.new(@assignment_attributes.merge(unit_id: nil))
    assert_not assignment.valid?
  end

  test "assignment has course through unit" do
    assignment = assignments(:assignment_one)
    assert assignment.course.present?
  end
end
