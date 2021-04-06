class User < ApplicationRecord
  include JwtToken
  authenticates_with_sorcery!

  has_many :articles, dependent: :destroy
  has_many :ordered_articles, -> { order('created_at desc') }, class_name: :Article, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_articles, through: :favorites, source: :article

  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :description, length: { maximum: 1_000 }

  def follow(other_user_id)
    return if id == other_user_id

    relationships.find_or_create_by(follow_id: other_user_id)
  end

  def unfollow(other_user_id)
    relationship = relationships.find_by(follow_id: other_user_id)
    relationship&.destroy!
  end

  def following?(other_user_id)
    followings.include?(User.find(other_user_id))
  end

  def favorite(article_id)
    favorites.find_or_create_by(article_id: article_id)
  end

  def unfavorite(article_id)
    favorites.find_by(article_id: article_id).destroy!
  end

  def favorite?(article)
    favorite_articles.include?(article)
  end
end
