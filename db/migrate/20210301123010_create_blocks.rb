class CreateBlocks < ActiveRecord::Migration[6.1]
  def change
    create_table :blocks do |t|
      t.references :day, null: false, foreign_key: true
      t.string :title
      t.string :place, null: false
      t.string :place_info
      t.text :comment
      t.datetime :arriving_time
      t.datetime :leaving_time
      t.integer :position, null: false

      t.timestamps
    end
  end
end
