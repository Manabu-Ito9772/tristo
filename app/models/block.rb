class Block < ApplicationRecord
  has_many :spendings, dependent: :destroy
  has_many :transportations, dependent: :destroy
  belongs_to :day

  validates :title, presence: true, length: { maximum: 100 }
  validates :place, length: { maximum: 100 }
  validates :place_info, length: { maximum: 500 }
  validates :comment, length: { maximum: 1_000 }
end
