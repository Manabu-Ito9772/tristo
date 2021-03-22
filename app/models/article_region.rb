class ArticleRegion < ApplicationRecord
  belongs_to :article
  belongs_to :region

  validates :article_id, uniqueness: { scope: :region_id }
end
