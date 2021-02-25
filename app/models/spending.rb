class Spending < ApplicationRecord
  belongs_to :info_block

  validates :genre, presence: true
end
