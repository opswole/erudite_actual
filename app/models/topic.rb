# == Schema Information
#
# Table name: topics
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  unit_id     :integer          not null
#
# Indexes
#
#  index_topics_on_unit_id  (unit_id)
#

class Topic < ApplicationRecord
  belongs_to :unit
  has_one :course, through: :unit
  has_many_attached :files, dependent: :destroy
  has_many :messages, as: :messageable, dependent: :destroy

  validates :title, :description, presence: true
end
