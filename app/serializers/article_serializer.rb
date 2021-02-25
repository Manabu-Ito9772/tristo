class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :start_date, :end_date, :created_at
  has_one :region
  has_many :info_blocks

  class RegionSerializer < ActiveModel::Serializer
    attributes :id, :name
    has_one :country

    class CountrySerializer < ActiveModel::Serializer
      attributes :id, :name, :currency
    end
  end

  class InfoBlockSerializer < ActiveModel::Serializer
    attributes :id, :day, :arriving_time, :leaving_time, :event, :place, :place_info, :comment, :position
    has_many :spendings
    has_many :transportations

    class SpendingSerializer < ActiveModel::Serializer
      attributes :id, :genre, :description, :cost
    end

    class TransportationSerializer < ActiveModel::Serializer
      attributes :id, :means, :description, :cost
    end
  end
end
