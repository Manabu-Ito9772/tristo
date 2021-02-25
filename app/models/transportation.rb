class Transportation < ApplicationRecord
  belongs_to :info_block

  validates :means, presence: true

  enum genre: { walking: 0, car: 1, subway: 2, bus: 3, plane: 4, ship: 5 }
end
