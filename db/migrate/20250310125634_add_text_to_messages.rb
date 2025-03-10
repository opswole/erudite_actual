class AddTextToMessages < ActiveRecord::Migration[8.0]
  def change
    add_column :messages, :content, :text

    change_column :messages, :user_id, :integer
    change_column :messages, :topic_id, :integer

    change_column_null :messages, :user_id, false
    change_column_null :messages, :topic_id, false

    add_index :messages, :user_id
    add_index :messages, :topic_id

    add_foreign_key :messages, :users
    add_foreign_key :messages, :topics
  end
end
