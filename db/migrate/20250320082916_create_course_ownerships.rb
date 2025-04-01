class CreateCourseOwnerships < ActiveRecord::Migration[8.0]
  def change
    create_table :course_ownerships do |t|
      t.references :course, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :course_ownerships, [ :course_id, :user_id ], unique: true
  end
end
