class User < ApplicationRecord
  include JwtToken
  authenticates_with_sorcery!

  has_many :articles, dependent: :destroy
  has_many :ordered_articles, -> { order('created_at desc') }, class_name: :Article, dependent: :destroy

  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, presence: true, if: -> { new_record? || changes[:crypted_password] }
  # validates :password_confirmation, presence: true,
  #           if: -> { new_record? || changes[:crypted_password] }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :description, length: { maximum: 1_000 }
end
