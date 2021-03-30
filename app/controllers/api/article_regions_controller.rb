class Api::ArticleRegionsController < ApplicationController
  before_action :authenticate!
  before_action :set_article_region, only: %i[destroy]
  skip_before_action :verify_authenticity_token

  def create
    @article_region = ArticleRegion.new(article_region_params)

    if @article_region.save
      render json: @article_region
    else
      render json: @article_region.errors, status: :bad_request
    end
  end

  def destroy
    @article_region.destroy!
    render json: @article_region
  end

  private

  def set_article_region
    @article_region = ArticleRegion.find(params[:id])
  end

  def article_region_params
    params.require(:article_region).permit(:article_id, :region_id)
  end
end
