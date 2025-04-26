# == Schema Information
#
# Table name: conversations
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#

require "test_helper"

class ConversationTest < ActiveSupport::TestCase
  setup do
    @conversation_attributes = conversations(:conversation_one).attributes.except("id", "created_at", "updated_at")
  end

  test "valid conversation is valid" do
    conversation = Conversation.new(@conversation_attributes)
    assert conversation.valid?
  end
end
