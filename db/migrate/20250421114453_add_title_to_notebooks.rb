class AddTitleToNotebooks < ActiveRecord::Migration[8.0]
  def change
    add_column :notebooks, :title, :string
  end
end
