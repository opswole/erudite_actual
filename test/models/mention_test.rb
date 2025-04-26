# == Schema Information
#
# Table name: mentions
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  message_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_mentions_on_message_id              (message_id)
#  index_mentions_on_user_id                 (user_id)
#  index_mentions_on_user_id_and_message_id  (user_id,message_id) UNIQUE
#

require "test_helper"

class MentionTest < ActiveSupport::TestCase
  setup do
    @mention_attributes = mentions(:mention_one).attributes.except("id", "created_at", "updated_at")
  end

  test "valid mention with user and message is valid" do
    mention = Mention.new(@mention_attributes)
    assert mention.valid?
  end

  test "invalid mention without user" do
    mention = Mention.new(@mention_attributes.merge(user_id: nil))
    assert_not mention.valid?
  end

  test "invalid mention without message" do
    mention = Mention.new(@mention_attributes.merge(message_id: nil))
    assert_not mention.valid?
  end
end
