class Unit < ApplicationRecord
  belongs_to :course
  has_many :topics, dependent: :destroy

  validates :title, :description, :course_id, presence: true
end
