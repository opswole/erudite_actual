class AddCourseIdToUnits < ActiveRecord::Migration[8.0]
  def change
    add_reference :units, :course, null: false, foreign_key: true
  end
end
