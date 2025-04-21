class CreateNotebooks < ActiveRecord::Migration[8.0]
  def change
    create_table :notebooks do |t|
      t.timestamps
    end
  end
end
