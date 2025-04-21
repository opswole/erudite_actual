# == Schema Information
#
# Table name: notebooks
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Notebook < ApplicationRecord
  has_rich_text :content
end
