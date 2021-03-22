class CreateArticleRegions < ActiveRecord::Migration[6.1]
  def change
    create_table :article_regions do |t|
      t.references :article, null: false, foreign_key: true
      t.references :region, null: false, foreign_key: true

      t.timestamps
    end
    add_index :article_regions, [:article_id, :region_id], unique: true
  end
end
