# == Schema Information
#
# Table name: course_ownerships
#
#  id         :integer          not null, primary key
#  course_id  :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_course_ownerships_on_course_id              (course_id)
#  index_course_ownerships_on_course_id_and_user_id  (course_id,user_id) UNIQUE
#  index_course_ownerships_on_user_id                (user_id)
#

class CourseOwnership < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validate :account_type

  private
  def account_type
    if user&.student?
      errors.add(:account_type, "Students cannot own courses.")
    end
  end
end
