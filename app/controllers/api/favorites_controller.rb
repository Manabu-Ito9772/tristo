class Api::FavoritesController < ApplicationController
  before_action :authenticate!, only: %i[favorite destroy]
  skip_before_action :verify_authenticity_token

  def favorite
    current_user.favorite(params[:id])
    render json: 200
  end

  def destroy
    current_user.unfavorite(params[:id])
    render json: 200
  end
end
