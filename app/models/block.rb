class Block < ApplicationRecord
  has_many_attached :images

  has_many :spendings, dependent: :destroy
  has_many :transportations, dependent: :destroy
  belongs_to :day

  validates :title, presence: true, length: { maximum: 100 }
  validates :place, length: { maximum: 100 }
  validates :place_info, length: { maximum: 500 }
  validates :comment, length: { maximum: 1_000 }
  validates :images, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..5.megabytes }
  validates :images, attachment: { maximum: 3 }

  def images_url
    if images.attached?
      images_array = []

      images.each do |image|
        url = Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
        images_array.push(url)
      end

      images_array
    else
      []
    end
  end
end
