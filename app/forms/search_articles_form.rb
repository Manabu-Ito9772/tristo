class SearchArticlesForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :japan, :boolean
  attribute :user_id, :integer
  attribute :country_id, :integer
  attribute :regions, :string
  attribute :tags, :string
  attribute :words, :string
  attribute :sort, :integer

  def search
    published_articles = Article.distinct.published

    relation = search_detail(published_articles)

    relation = published_articles.where(id: relation.map(&:id))

    if sort.zero?
      relation.order(created_at: :desc).to_a
    elsif sort == 1
      relation.order(created_at: :asc).to_a
    elsif sort == 2
      relation.includes(:users).sort { |a, b| b.users.size <=> a.users.size }
    end
  end

  def search_detail(published_articles)
    relation = if japan.present?
                 published_articles.japan
               else
                 published_articles.world
               end

    relation = relation.where(user_id: [User.find(user_id).following_ids]) if user_id.present?
    relation = relation.by_country(country_id) if country_id.present?
    words_split.each do |word|
      relation = relation.keyword(word)
    end
    regions_split.each do |region_id|
      relation &= published_articles.by_region(region_id)
    end
    tags_split.each do |tag|
      relation &= published_articles.by_tag(tag)
    end

    relation
  end

  private

  def regions_split
    regions.present? ? regions.split(nil) : []
  end

  def tags_split
    tags.present? ? tags.split(nil) : []
  end

  def words_split
    words.present? ? words.split(nil) : []
  end
end
