class Topic < ApplicationRecord
  belongs_to :unit
  has_many_attached :files, dependent: :destroy

  validates :title, :description, :unit_id, presence: true
end
