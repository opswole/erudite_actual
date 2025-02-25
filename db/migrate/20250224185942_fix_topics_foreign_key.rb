class FixTopicsForeignKey < ActiveRecord::Migration[8.0]
  def change
    remove_reference :topics, :unit, index: true, foreign_key: true
    add_reference :topics, :course, null: false, index: true, foreign_key: true
  end
end
