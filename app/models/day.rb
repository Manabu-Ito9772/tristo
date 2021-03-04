class Day < ApplicationRecord
  has_many :info_blocks, dependent: :destroy
  belongs_to :article

  validates :number, presence: true
end
