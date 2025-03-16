# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  topic_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  content    :text
#  title      :string
#
# Indexes
#
#  index_messages_on_topic_id  (topic_id)
#  index_messages_on_user_id   (user_id)
#

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :topic

  has_many :mentions, dependent: :destroy
  has_many :tagged_users, through: :mentions, source: :user

  validates :content, presence: true

  broadcasts_to ->(message) { [ message.topic, :messages ] }, partial: "user/messages/message"
end
