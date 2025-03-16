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

class Mention < ApplicationRecord
  belongs_to :user
  belongs_to :message
end
