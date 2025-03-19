class AddTaggableByStudentsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :taggable_by_students, :boolean, default: true
  end
end
