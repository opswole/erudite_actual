# == Schema Information
#
# Table name: topics
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  unit_id     :integer          not null
#
# Indexes
#
#  index_topics_on_unit_id  (unit_id)
#

require "test_helper"

class TopicTest < ActiveSupport::TestCase
  setup do
    @topic_attributes = topics(:topic_one).attributes.except("id", "created_at", "updated_at")
  end

  test "valid topic with title and unit is valid" do
    topic = Topic.new(@topic_attributes)
    assert topic.valid?
  end

  test "invalid topic without title (nil)" do
    topic = Topic.new(@topic_attributes.merge(title: nil))
    assert_not topic.valid?
  end

  test "invalid topic with blank title" do
    topic = Topic.new(@topic_attributes.merge(title: ""))
    assert_not topic.valid?
  end

  test "invalid topic without unit" do
    topic = Topic.new(@topic_attributes.merge(unit_id: nil))
    assert_not topic.valid?
  end

  test "topic has course through unit" do
    topic = topics(:topic_one)
    assert topic.course.present?
  end
end
