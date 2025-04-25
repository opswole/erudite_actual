class UpdateUserRefOnNotebooks < ActiveRecord::Migration[8.0]
  def change
    change_table :notebooks do |t|
      t.remove_index name: "index_notebooks_on_user_and_notebookable"
      t.remove_index name: "index_notebooks_on_user_id"

      t.remove :user_id

      t.references :user, null: false, foreign_key: true
    end
  end
end
