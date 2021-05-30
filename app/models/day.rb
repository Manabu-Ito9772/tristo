class Day < ApplicationRecord
  MAX_DAYS_COUNT = 14

  has_many :blocks, dependent: :destroy
  has_many :ordered_blocks, -> { order('position asc') }, class_name: :Block, dependent: :destroy
  belongs_to :article

  validate :days_count_must_be_within_limit

  private

  def days_count_must_be_within_limit
    errors.add(:base, "days count limit: #{MAX_DAYS_COUNT}") if article.days.count >= MAX_DAYS_COUNT
  end
end
