class Api::RegionsController < ApplicationController
  def show
    regions = Country.find(params[:id]).regions.order(order: :asc)
    render json: regions, only: %i[id name]
  end
end
