class CreateTransportations < ActiveRecord::Migration[6.1]
  def change
    create_table :transportations do |t|
      t.references :block, null: false, foreign_key: true
      t.integer :means, null: false
      t.string :description
      t.string :cost

      t.timestamps
    end
  end
end
