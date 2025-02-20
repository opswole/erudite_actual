class Topic < ApplicationRecord
  belongs_to :unit, dependent: :destroy
  has_many_attached :files, dependent: :destroy
  validates :title, :description, presence: true
end
