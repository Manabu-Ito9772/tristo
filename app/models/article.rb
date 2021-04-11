class Article < ApplicationRecord
  before_save :extract_url_from_map

  has_many :days, dependent: :destroy
  has_many :article_regions, dependent: :destroy
  has_many :regions, through: :article_regions
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  belongs_to :user
  belongs_to :country

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 3_000 }
  validates :map, length: { maximum: 300 }
  validates :status, presence: true

  enum status: { draft: 0, published: 1 }

  scope :draft, -> { where(status: 0) }
  scope :published, -> { where(status: 1) }
  scope :japan, -> { joins(:country).where(country: { name: '日本' }) }
  scope :world, -> { joins(:country).where.not(country: { name: '日本' }) }
  scope :by_country, ->(country_id) { joins(:country).where(country: { id: country_id }) }
  scope :by_region, ->(region_id) { joins(:article_regions).where(article_regions: { region_id: region_id }) }
  scope :by_tag, ->(tag) { joins(:tags).where('tags.name = ?', tag) }
  scope :keyword, ->(word) { where('title LIKE ? OR description LIKE ?', "%#{word}%", "%#{word}%") }

  def self.change_to_json(articles)
    articles.as_json(
      only: %i[id title description status start_date end_date],
      include: [
        { user: { only: %i[id name] } },
        { country: { only: %i[id name currency] } },
        { regions: { only: %i[id name] } },
        { favorites: { only: :user_id } },
        { article_tags: { only: :id, include: { tag: { only: :name } } } }
      ]
    )
  end

  private

  def extract_url_from_map
    self.map = URI.extract(map, ['https']).first unless map.blank?
  end
end
