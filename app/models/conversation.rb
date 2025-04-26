# == Schema Information
#
# Table name: conversations
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#

class Conversation < ApplicationRecord
    has_many :conversation_users, dependent: :destroy
    has_many :users, through: :conversation_users
    has_many :messages, as: :messageable, dependent: :destroy
end
