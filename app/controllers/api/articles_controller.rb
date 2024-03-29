class Api::ArticlesController < ApplicationController
  before_action :authenticate!, only: %i[create update destroy delete_eyecatch]
  before_action :set_article, only: %i[update destroy delete_eyecatch]
  skip_before_action :verify_authenticity_token

  include Pagination

  def index
    articles = Article.published.world.page(params[:page]).per(10).order(created_at: :desc)
    pagenation = resources_with_pagination(articles)
    articles = Article.change_to_json(articles)
    render json: { articles: articles, kaminari: pagenation }
  end

  def japan
    articles = Article.published.japan.page(params[:page]).per(10).order(created_at: :desc)
    pagenation = resources_with_pagination(articles)
    articles = Article.change_to_json(articles)
    render json: { articles: articles, kaminari: pagenation }
  end

  def user_articles
    articles = User.find(params[:id]).articles.published.page(params[:page]).per(10).order(created_at: :desc)
    pagenation = resources_with_pagination(articles)
    articles = Article.change_to_json(articles)
    render json: { articles: articles, kaminari: pagenation }
  end

  def user_articles_draft
    articles = User.find(params[:id]).articles.draft.page(params[:page]).per(10).order(created_at: :desc)
    pagenation = resources_with_pagination(articles)
    articles = Article.change_to_json(articles)
    render json: { articles: articles, kaminari: pagenation }
  end

  def user_favorites
    articles = User.find(params[:id]).favorite_articles.published.includes(:favorites).order("favorites.created_at DESC").page(params[:page]).per(10)
    pagenation = resources_with_pagination(articles)
    articles = Article.change_to_json(articles)
    render json: { articles: articles, kaminari: pagenation }
  end

  def search
    search_articles_form = SearchArticlesForm.new(search_params)
    articles_array = search_articles_form.search
    articles = Kaminari.paginate_array(articles_array).page(params[:page]).per(10)
    pagenation = resources_with_pagination(articles)
    articles_json = Article.change_to_json(articles)
    render json: { articles: articles_json, kaminari: pagenation }
  end

  def user_articles_count
    articles_count = User.find(params[:id]).articles.published.count
    render json: articles_count
  end

  def show
    article = Article.include_relations.find(params[:id])

    if article.published? || article.user == current_user
      render json: article
    else
      render json: false, status: 404
    end
  end

  def create
    article = current_user.articles.build(article_params)

    if article.save
      render json: article
    else
      render json: article.errors, status: :bad_request
    end
  end

  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :bad_request
    end
  end

  def destroy
    @article.destroy!
    render json: @article
  end

  def delete_eyecatch
    @article.eyecatch.purge if @article.eyecatch.attached?
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:country_id, :title, :description, :map, :status, :start_date, :end_date, :created_at, :eyecatch)
  end

  def search_params
    params[:q]&.permit(:japan, :user_id, :country_id, :regions, :tags, :words, :sort)
  end
end
