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
  # test "the truth" do
  #   assert true
  # end
end
