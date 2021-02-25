class Api::ArticlesController < ApplicationController
  def index
    @articles = Article.all.order(created_at: :desc)
    render json: @articles, include: { region: [:country] }
  end

  def show
    @article = Article.find(params[:id])
    render json: @article, include: { info_blocks: %i[spendings transportations] }
  end

  def create; end

  def update; end

  def destroy; end
end
