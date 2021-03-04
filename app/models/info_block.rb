class InfoBlock < ApplicationRecord
  has_many :spendings, dependent: :destroy
  has_many :transportations, dependent: :destroy
  belongs_to :day

  validates :position, presence: true
end
