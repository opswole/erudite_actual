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

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :messageable, polymorphic: true

  has_many :mentions, dependent: :destroy
  has_many :tagged_users, through: :mentions, source: :user

  validates :content, presence: true

  after_create_commit do
    broadcast_append_to [ messageable, :messages ],
                        partial: "messages/message",
                        target: "messages-container"
  end
end
