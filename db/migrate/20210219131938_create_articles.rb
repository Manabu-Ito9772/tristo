class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.references :user, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.string :map
      t.integer :status, default: 0, null: false
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
