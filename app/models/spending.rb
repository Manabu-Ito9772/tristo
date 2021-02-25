class Spending < ApplicationRecord
  belongs_to :info_block

  validates :genre, presence: true

  # enum genre: { : 1, doing: 2, done: 3 }
end
