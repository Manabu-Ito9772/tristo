class CreateInfoBlocks < ActiveRecord::Migration[6.1]
  def change
    create_table :info_blocks do |t|
      t.references :article, null: false, foreign_key: true
      t.integer :day, null: false
      t.datetime :arriving_time
      t.datetime :leaving_time
      t.string :event, null: false
      t.string :place
      t.string :place_info
      t.text :comment
      t.integer :position, null: false

      t.timestamps
    end
  end
end
