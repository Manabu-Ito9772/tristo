class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'

  validates :user_id, presence: true
  validates :follow_id, presence: true
  validates :user_id, uniqueness: { scope: :follow_id }

  def self.change_following_to_json(relationships)
    relationships.as_json(
      only: :id,
      include: [{ follow: { only: %i[id name avatar], methods: [:avatar_url] } }]
    )
  end

  def self.change_followers_to_json(relationships)
    relationships.as_json(
      only: :id,
      include: [{ user: { only: %i[id name avatar], methods: [:avatar_url] } }]
    )
  end
end
