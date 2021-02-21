class Article < ApplicationRecord
  belongs_to :region

  validates :title, presence: true
  validates :status, presence: true
end
