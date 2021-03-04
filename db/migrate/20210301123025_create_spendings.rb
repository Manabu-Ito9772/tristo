class CreateSpendings < ActiveRecord::Migration[6.1]
  def change
    create_table :spendings do |t|
      t.references :info_block, null: false, foreign_key: true
      t.integer :genre, null: false
      t.string :description, null: false
      t.string :cost

      t.timestamps
    end
  end
end
