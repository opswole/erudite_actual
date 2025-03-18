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

# app/models/mention.rb
class Mention < ApplicationRecord
  belongs_to :user
  belongs_to :message

  after_create_commit :broadcast_to_user

  private

  def broadcast_to_user
    broadcast_replace_to(
      "user_#{user_id}_notifications",
      target: "notifications",
      partial: "user/notifications/mentions",
      locals: { mentions: user.mentions.includes(:message).order(created_at: :desc) }
    )
  end
end
