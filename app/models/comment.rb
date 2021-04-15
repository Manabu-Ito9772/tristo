class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :body, presence: true, length: { maximum: 500 }

  def self.change_to_json(comments)
    comments.as_json(
      only: %i[id body],
      include: [{ user: { only: %i[id name avatar], methods: [:avatar_url] } }]
    )
  end
end
