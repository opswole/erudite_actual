class MakeMessagesPolymorphic < ActiveRecord::Migration[8.0]
  def change
    add_belongs_to :messages, :messageable, polymorphic: true
    remove_foreign_key :messages, :topics
    remove_index :messages, :topic_id
    remove_column :messages, :topic_id, :integer
  end
end
