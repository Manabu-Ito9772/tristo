class CreateCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :countries do |t|
      t.string :name, null: false
      t.string :currency, null: false
      t.integer :order

      t.timestamps
    end
  end
end
