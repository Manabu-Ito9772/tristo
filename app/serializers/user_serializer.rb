class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :description
  has_many :ordered_articles
  has_many :followings
  has_many :followers

  class ArticleSerializer < ActiveModel::Serializer
    attributes :id, :title, :description, :map, :status, :start_date, :end_date
    has_one :user
    has_one :country
    has_many :regions
    has_many :article_tags

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
  end

  class UserSerializer < ActiveModel::Serializer
    attributes :id
  end

  class UserSerializer < ActiveModel::Serializer
    attributes :id
  end
end
