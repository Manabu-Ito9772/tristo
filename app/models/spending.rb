class Spending < ApplicationRecord
  before_save :set_genre_other
  belongs_to :block

  validates :description, presence: true, length: { maximum: 100 }
  validates :cost, presence: true, length: { maximum: 50 }, numericality: true

  enum genre: { touring: 0, activity: 1, food: 2, souvenir: 3, accommodation: 4, other: 5 }

  private

  def set_genre_other
    return if genre

    self.genre = 'other'
  end
end
