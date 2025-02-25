class OrganiseEnrollments < ActiveRecord::Migration[8.0]
  # Topics to units not courses
  change_table :topics do |t|
    remove_reference :topics, :course, foreign_key: true, index: true
    add_reference :topics, :unit, null: false, foreign_key: true
  end

  # Units to courses
  change_table :units do |t|
    remove_reference :units, :topic, foreign_key: true, index: true
  end
end
