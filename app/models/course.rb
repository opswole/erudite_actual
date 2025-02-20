class Course < ApplicationRecord
  has_many_attached :units, dependent: :destroy
end
