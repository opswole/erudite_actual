# == Schema Information
#
# Table name: enrollments
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  course_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_enrollments_on_course_id  (course_id)
#  index_enrollments_on_user_id    (user_id) UNIQUE
#

class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  # Account can only have one degree programme
  validates :user_id, uniqueness: true

  after_commit :create_user_notebooks, on: :create

  private
  def create_user_notebooks
    user.units.each do |unit|
      Notebook.create!(title: "#{unit.title} Notebook", notebookable: unit, user: user)
    end
  end
end
