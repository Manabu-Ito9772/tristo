class Api::ArticleTagsController < ApplicationController
  before_action :authenticate!
  skip_before_action :verify_authenticity_token

  def create
    article_tag = ArticleTag.new(article_tag_params)

    if article_tag.save
      render json: article_tag
    else
      render json: article_tag.errors, status: :bad_request
    end
  end

  def destroy
    article_tag = ArticleTag.find(params[:id])

    article_tag.destroy!
    render json: article_tag
  end

  private

  def article_tag_params
    params.require(:article_tag).permit(:article_id, :tag_id)
  end
end
