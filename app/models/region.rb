class Region < ApplicationRecord
  has_many :article_regions, dependent: :destroy
  has_many :articles, through: :article_regions
  belongs_to :country

  validates :name, presence: true
end
