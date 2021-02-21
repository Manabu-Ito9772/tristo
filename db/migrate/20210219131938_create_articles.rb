class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.references :region, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.integer :status, default: 0, null: false
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
