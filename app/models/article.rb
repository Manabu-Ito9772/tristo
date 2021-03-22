class Article < ApplicationRecord
  before_save :extract_url_from_map

  has_many :days, dependent: :destroy
  has_many :article_regions, dependent: :destroy
  has_many :regions, through: :article_regions
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
  belongs_to :country

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 3_000 }
  validates :map, length: { maximum: 300 }
  validates :status, presence: true

  enum status: { draft: 0, published: 1 }

  scope :published, -> { where(status: 1).order(created_at: :desc) }

  private

  def extract_url_from_map
    self.map = URI.extract(map, ['https']).first unless map.blank?
  end
end
