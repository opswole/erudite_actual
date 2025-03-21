class RemoveOwnerFromCourses < ActiveRecord::Migration[8.0]
  def change
    remove_column :courses, :owner, :string
  end
end
