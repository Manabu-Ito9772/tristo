class Transportation < ApplicationRecord
  belongs_to :info_block

  validates :means, presence: true

  enum means: { walking: 0, car: 1, taxi: 2, bus: 3, subway: 4, ship: 5, plane: 6, bicycle: 7, motorcycle: 8, other: 9 }
end
