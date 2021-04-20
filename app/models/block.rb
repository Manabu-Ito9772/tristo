class Block < ApplicationRecord
  has_one_attached :image

  has_many :spendings, dependent: :destroy
  has_many :transportations, dependent: :destroy
  belongs_to :day

  validates :title, presence: true, length: { maximum: 100 }
  validates :place, length: { maximum: 100 }
  validates :place_info, length: { maximum: 500 }
  validates :comment, length: { maximum: 1_000 }
  validates :image, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..5.megabytes }

  def image_url
    image.attached? ? Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true) : nil
  end
end
