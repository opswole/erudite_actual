class AddUsersToConversation < ActiveRecord::Migration[8.0]
  def change
    add_reference :conversations, :sender, null: false, foreign_key: { to_table: :users }, index: true
    add_reference :conversations, :recipient, null: false, foreign_key: { to_table: :users }, index: true
  end
end
