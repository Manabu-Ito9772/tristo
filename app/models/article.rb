class Article < ApplicationRecord
  has_many :days, dependent: :destroy
  belongs_to :region

  validates :title, presence: true
  validates :status, presence: true
end
