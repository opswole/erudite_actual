# == Schema Information
#
# Table name: assignments
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  deadline    :string
#  unit_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_assignments_on_unit_id  (unit_id)
#

class Assignment < ApplicationRecord
  belongs_to :unit
  has_one :course, through: :unit
  has_many :messages, as: :messageable, dependent: :destroy
  has_many_attached :files, dependent: :destroy
end
