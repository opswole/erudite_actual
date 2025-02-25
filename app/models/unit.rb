# == Schema Information
#
# Table name: units
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  course_id   :integer          not null
#
# Indexes
#
#  index_units_on_course_id  (course_id)
#

class Unit < ApplicationRecord
  belongs_to :course
  has_many :topics, dependent: :destroy

  validates :title, :description, presence: true
end
