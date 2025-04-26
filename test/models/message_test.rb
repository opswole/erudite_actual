# == Schema Information
#
# Table name: messages
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  content          :text
#  title            :string
#  messageable_type :string
#  messageable_id   :integer
#
# Indexes
#
#  index_messages_on_messageable  (messageable_type,messageable_id)
#  index_messages_on_user_id      (user_id)
#

require "test_helper"

class MessageTest < ActiveSupport::TestCase
    setup do
      @message_attributes = messages(:message_one).attributes.except("id", "created_at", "updated_at")
    end

    test "valid message with content, user, and messageable is valid" do
      message = Message.new(@message_attributes)
      assert message.valid?
    end

    test "invalid message without content (nil)" do
      message = Message.new(@message_attributes.merge(content: nil))
      assert_not message.valid?
    end

    test "invalid message with blank content" do
      message = Message.new(@message_attributes.merge(content: ""))
      assert_not message.valid?
    end

    test "invalid message without user" do
      message = Message.new(@message_attributes.merge(user_id: nil))
      assert_not message.valid?
    end

    test "invalid message without messageable" do
      message = Message.new(@message_attributes.merge(messageable_id: nil, messageable_type: nil))
      assert_not message.valid?
    end
end
