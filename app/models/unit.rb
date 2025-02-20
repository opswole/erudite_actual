class Unit < ApplicationRecord
  belongs_to :course
  has_many :topics, dependent: :destroy

  validates :title, :description, presence: true
end
