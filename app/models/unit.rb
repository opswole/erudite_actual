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
  audited
  belongs_to :course
  has_many :topics, dependent: :destroy
  has_one :assignment, dependent: :destroy
  has_many :notebooks, as: :notebookable, dependent: :destroy

  validates :title, :description, presence: true
  validates :course, presence: true
end
