class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status, :start_date, :end_date, :created_at, :updated_at
  has_one :region

  class RegionSerializer < ActiveModel::Serializer
    attributes :id, :name
    has_one :country

    class CountrySerializer < ActiveModel::Serializer
      attributes :id, :name, :currency
    end
  end
end
