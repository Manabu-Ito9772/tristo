class Region < ApplicationRecord
  has_many :articles, dependent: :destroy
  belongs_to :country

  validates :name, presence: true
end
