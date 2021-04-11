class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :user_id, presence: true
  validates :article_id, presence: true
  validates :user_id, uniqueness: { scope: :article_id }

  def self.get_favorite_articles(favorites)
    favorite_articles = []

    favorites.each do |favo|
      favorite_articles.push(favo.article) if favo.article.status == 'published'
    end

    favorite_articles
  end
end
