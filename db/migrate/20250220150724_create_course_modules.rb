class CreateCourseModules < ActiveRecord::Migration[8.0]
  def change
    create_table :course_modules do |t|
      t.string :title
      t.string :description
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
