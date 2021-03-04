class Spending < ApplicationRecord
  belongs_to :info_block

  validates :genre, presence: true

  enum genre: { touring: 0, activity: 1, food: 2, souvenir: 3, accommodation: 4, other: 5 }
end
