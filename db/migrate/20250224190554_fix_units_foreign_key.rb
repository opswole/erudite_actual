class FixUnitsForeignKey < ActiveRecord::Migration[8.0]
  def change
    remove_reference :units, :course, index: true, foreign_key: true
    add_reference :units, :topic, null: false, foreign_key: true, index: true
  end
end
