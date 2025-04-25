class MakeNotebooksPolymorphic < ActiveRecord::Migration[8.0]
  def change
    add_belongs_to :notebooks, :notebookable, polymorphic: true, null: false
    add_belongs_to :notebooks, :user, null: false, foreign_key: true

    add_index :notebooks, [ :user_id, :notebookable_id, :notebookable_type ],
              unique: true,
              name: "index_notebooks_on_user_and_notebookable"
  end
end
