class InfoBlock < ApplicationRecord
  has_many :spendings, dependent: :destroy
  has_many :transportations, dependent: :destroy
  belongs_to :article

  validates :day, presence: true
  validates :position, presence: true
end
