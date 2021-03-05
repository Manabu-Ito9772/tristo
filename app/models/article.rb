class Article < ApplicationRecord
  before_save :extract_url_from_map

  has_many :days, dependent: :destroy
  belongs_to :region

  validates :title, presence: true
  validates :status, presence: true

  private

  def extract_url_from_map
    self.map = URI.extract(map, ['https']).first
  end
end
