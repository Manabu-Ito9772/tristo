class Block < ApplicationRecord
  MAX_BLOCKS_COUNT = 20

  before_save :null_to_nill

  has_one_attached :image

  has_many :spendings, dependent: :destroy
  has_many :transportations, dependent: :destroy
  belongs_to :day

  validates :title, length: { maximum: 100 }
  validates :place, presence: true, length: { maximum: 100 }
  validates :place_info, length: { maximum: 500 }
  validates :comment, length: { maximum: 1_000 }
  validates :image, attachment: { content_type: %r{\Aimage/(png|jpeg)\Z}, maximum: 5_242_880 }
  validate :blocks_count_must_be_within_limit

  def image_url
    image.attached? ? Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true) : nil
  end

  private

  def null_to_nill
    self.title = nil if title == 'null'
    self.place_info = nil if place_info == 'null'
    self.comment = nil if comment == 'null'
  end

  def blocks_count_must_be_within_limit
    errors.add(:base, "blocks count limit: #{MAX_BLOCKS_COUNT}") if day.blocks.count >= MAX_BLOCKS_COUNT
  end
end
