class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :map, :status, :start_date, :end_date
  has_one :country
  has_many :regions
  has_many :article_regions
  has_many :article_tags
  has_many :days

  class CountrySerializer < ActiveModel::Serializer
    attributes :id, :name, :currency
  end

  class RegionSerializer < ActiveModel::Serializer
    attributes :id, :name
  end

  class ArticleRegionSerializer < ActiveModel::Serializer
    attributes :id
  end

  class ArticleTagSerializer < ActiveModel::Serializer
    attributes :id
    has_one :tag

    class TagSerializer < ActiveModel::Serializer
      attributes :name
    end
  end

  class DaySerializer < ActiveModel::Serializer
    attributes :id, :number
    has_many :blocks

    class BlockSerializer < ActiveModel::Serializer
      attributes :id, :day_id, :title, :place, :place_info, :comment, :arriving_time, :leaving_time
      has_many :spendings
      has_many :transportations

      class SpendingSerializer < ActiveModel::Serializer
        attributes :id, :block_id, :genre, :description, :cost
      end

      class TransportationSerializer < ActiveModel::Serializer
        attributes :id, :block_id, :means, :description, :cost
      end
    end
  end
end
