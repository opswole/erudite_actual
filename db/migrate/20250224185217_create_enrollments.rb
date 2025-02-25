class CreateEnrollments < ActiveRecord::Migration[8.0]
  def change
    create_table :enrollments do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.references :course, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
