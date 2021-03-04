class CreateDays < ActiveRecord::Migration[6.1]
  def change
    create_table :days do |t|
      t.references :article, null: false, foreign_key: true
      t.integer :number, null: false

      t.timestamps
    end
  end
end
