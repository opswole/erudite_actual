# == Schema Information
#
# Table name: conversation_users
#
#  id              :integer          not null, primary key
#  user_id         :integer          not null
#  conversation_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_conversation_users_on_conversation_id  (conversation_id)
#  index_conversation_users_on_user_id          (user_id)
#

require "test_helper"

class ConversationUserTest < ActiveSupport::TestCase
  setup do
    @conversation_user_attributes = conversation_users(:conversation_user_one).attributes.except("id", "created_at", "updated_at")
  end

  test "valid conversation_user with user and conversation is valid" do
    conversation_user = ConversationUser.new(@conversation_user_attributes)
    assert conversation_user.valid?
  end

  test "invalid conversation_user without user" do
    conversation_user = ConversationUser.new(@conversation_user_attributes.merge(user_id: nil))
    assert_not conversation_user.valid?
  end

  test "invalid conversation_user without conversation" do
    conversation_user = ConversationUser.new(@conversation_user_attributes.merge(conversation_id: nil))
    assert_not conversation_user.valid?
  end
end
