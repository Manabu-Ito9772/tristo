class CreateSpendings < ActiveRecord::Migration[6.1]
  def change
    create_table :spendings do |t|
      t.references :block, null: false, foreign_key: true
      t.integer :genre
      t.string :description, null: false
      t.string :cost, null: false

      t.timestamps
    end
  end
end
