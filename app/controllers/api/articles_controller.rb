class Api::ArticlesController < ApplicationController
  before_action :set_article, only: %i[show update destroy]
  skip_before_action :verify_authenticity_token

  def index
    @articles = Article.published
    render json: @articles, include: [:country, :regions, article_tags: [:tag]]
  end

  def show
    render json: @article
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      render json: @article
    else
      render json: @article.errors, status: :bad_request
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

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:country_id, :title, :description, :map, :status, :start_date, :end_date)
  end
end
