class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body
  has_one :user

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :name
  end
end
