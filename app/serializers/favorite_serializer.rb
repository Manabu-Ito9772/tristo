class FavoriteSerializer < ActiveModel::Serializer
  attributes :id
  has_one :article

  class ArticleSerializer < ActiveModel::Serializer
    attributes :id, :title, :description, :status, :start_date, :end_date
    has_one :user
    has_one :country
    has_many :regions
    has_many :article_tags
    has_many :favorites

    class UserSerializer < ActiveModel::Serializer
      attributes :id, :name
    end

    class CountrySerializer < ActiveModel::Serializer
      attributes :id, :name, :currency
    end

    class RegionSerializer < ActiveModel::Serializer
      attributes :id, :name
    end

    class ArticleTagSerializer < ActiveModel::Serializer
      attributes :id
      has_one :tag

      class TagSerializer < ActiveModel::Serializer
        attributes :name
      end
    end

    class FavoriteSerializer < ActiveModel::Serializer
      attributes :user_id
    end
  end
end
