class Api::TagsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @tag = Tag.find_by(name: params[:name])
    if @tag.present?
      render json: @tag
    else
      @tag = Tag.new(name: params[:name])
      if @tag.save
        render json: @tag
      else
        render json: @tag.errors, status: :bad_request
      end
    end
  end
end
