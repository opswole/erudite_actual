class Course < ApplicationRecord
  has_many :units, dependent: :destroy
  validates :title, :owner, presence: true
end
