class Country < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :regions, dependent: :destroy

  validates :name, presence: true
  validates :currency, presence: true
end
