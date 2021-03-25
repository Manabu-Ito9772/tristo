class Day < ApplicationRecord
  has_many :blocks, dependent: :destroy
  has_many :ordered_blocks, -> { order('id asc') }, class_name: :Block, dependent: :destroy
  belongs_to :article
end
