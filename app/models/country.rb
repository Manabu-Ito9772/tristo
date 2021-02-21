class Country < ApplicationRecord
  has_many :regions, dependent: :destroy

  validates :name, presence: true
  validates :currency, presence: true
end
