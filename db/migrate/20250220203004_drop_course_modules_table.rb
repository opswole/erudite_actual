class DropCourseModulesTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :course_modules
  end
end
