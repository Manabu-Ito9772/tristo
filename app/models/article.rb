class Article < ApplicationRecord
  has_many :info_blocks, dependent: :destroy
  belongs_to :region

  validates :title, presence: true
  validates :status, presence: true
end
