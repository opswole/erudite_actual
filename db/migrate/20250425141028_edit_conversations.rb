class EditConversations < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :conversations, :users, column: :sender_id
    remove_foreign_key :conversations, :users, column: :recipient_id

    remove_index :conversations, name: "index_conversations_on_recipient_id"
    remove_index :conversations, name: "index_conversations_on_sender_id"

    remove_column :conversations, :sender_id, :integer
    remove_column :conversations, :recipient_id, :integer

    add_column :conversations, :name, :string
  end
end
