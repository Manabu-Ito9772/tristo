class CountrySerializer < ActiveModel::Serializer
  attributes :id, :name, :currency
  has_many :regions

  class RegionSerializer < ActiveModel::Serializer
    attributes :id, :name
  end
end
