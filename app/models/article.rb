class Article < ApplicationRecord
  before_save :extract_url_from_map
  before_save :null_to_nill

  has_one_attached :eyecatch

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
  validates :description, length: { maximum: 500 }
  validates :map, length: { maximum: 300 }
  validates :status, presence: true
  validates :eyecatch, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..5.megabytes }

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
        { user: { only: %i[id name avatar], methods: [:avatar_url] } },
        { country: { only: %i[id name currency] } },
        { article_regions: { only: :id, include: { region: { only: :name } } } },
        { favorites: { only: :user_id } },
        { article_tags: { only: :id, include: { tag: { only: :name } } } }
      ],
      methods: [:eyecatch_url]
    )
  end

  def self.include_relations
    Article.includes(:user, :country, :article_regions, :article_tags, :favorites,
                     [days: [ordered_blocks: [:spendings, :transportations, image_attachment: :blob]]])
  end

  def eyecatch_url
    eyecatch.attached? ? Rails.application.routes.url_helpers.rails_blob_path(eyecatch, only_path: true) : nil
  end

  private

  def extract_url_from_map
    self.map = URI.extract(map, ['https']).first unless map.blank?
  end

  def null_to_nill
    return if description != 'null'

    self.description = nil
  end
end
