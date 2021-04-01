class RelationshipSerializer < ActiveModel::Serializer
  attributes :id
  has_one :user
  has_one :follow

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :name
  end
end
