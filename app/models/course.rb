class Course < ApplicationRecord
  has_many_attached :files, dependent: :destroy
end
