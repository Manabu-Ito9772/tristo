class Day < ApplicationRecord
  has_many :blocks, dependent: :destroy
  belongs_to :article
end
