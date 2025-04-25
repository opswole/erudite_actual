# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Course < ApplicationRecord
  # Users
  has_many :course_ownerships, dependent: :destroy
  has_many :owners, through: :course_ownerships, source: :user
  has_many :enrollments, dependent: :destroy
  has_many :users, through: :enrollments, dependent: :destroy
  # Content
  has_many :units, dependent: :destroy
  has_many :topics, through: :units
  validates :title, presence: true

  accepts_nested_attributes_for :course_ownerships, reject_if: :all_blank

  private
end
