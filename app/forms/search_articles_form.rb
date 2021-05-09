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
    relation = Article.distinct.published
    relation = single_search(relation)
    relation = multiple_search(relation)

    if sort.zero?
      relation.order(created_at: :desc).to_a
    elsif sort == 1
      relation.order(created_at: :asc).to_a
    elsif sort == 2
      relation.includes(:users).sort { |a, b| b.users.size <=> a.users.size }
    end
  end

  private

  def single_search(relation)
    relation = japan.present? ? relation.japan : relation.world
    relation = relation.where(user_id: [User.find(user_id).following_ids]) if user_id.present?
    relation = relation.by_country(country_id) if country_id.present?

    relation
  end

  def multiple_search(relation)
    if regions.present? || tags.present? || words.present?
      relation_array = []
      relation_array = search_regions(relation, relation_array) if regions.present?
      relation_array = search_tags(relation, relation_array) if tags.present?
      relation_array = search_words(relation, relation_array) if words.present?
      relation = relation.where(id: relation_array.map(&:id))
    end

    relation
  end

  def search_regions(relation, relation_array)
    regions_split.each do |region_id|
      relation_array += relation.by_region(region_id)
    end
    relation_array
  end

  def search_tags(relation, relation_array)
    tags_array = []
    tags_split.each do |tag|
      tags_array += relation.by_tag(tag)
    end
    tags_array &= relation_array if relation_array.present?

    tags_array
  end

  def search_words(relation, relation_array)
    words_array = []
    words_split.each do |word|
      words_array += relation.keyword(word)
    end
    words_array &= relation_array if relation_array.present?

    words_array
  end

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
