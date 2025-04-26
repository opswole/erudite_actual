class MakeAssignmentDeadlineDateTime < ActiveRecord::Migration[8.0]
  def change
    change_column :assignments, :deadline, :datetime
  end
end
