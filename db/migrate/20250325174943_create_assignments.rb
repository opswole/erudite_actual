class CreateAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :assignments do |t|
      t.string :title
      t.string :description
      t.string :deadline
      t.references :unit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
