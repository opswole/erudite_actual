class CreateConversationUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :conversation_users, force: :cascade do |t|
      t.integer :user_id, null: false
      t.integer :conversation_id, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false

      t.index [ :conversation_id ], name: "index_conversation_users_on_conversation_id"
      t.index [ :user_id ], name: "index_conversation_users_on_user_id"
    end

    add_foreign_key :conversation_users, :users, column: :user_id
    add_foreign_key :conversation_users, :conversations, column: :conversation_id
  end
end
