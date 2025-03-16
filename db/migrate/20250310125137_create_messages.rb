class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.string :user_id
      t.string :topic_id

      t.timestamps
    end
  end
end
