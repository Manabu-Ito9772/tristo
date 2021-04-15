class Api::CountriesController < ApplicationController
  before_action :set_country, only: %i[show]

  def index
    @countries = Country.all.order(order: :asc)
    render json: @countries, only: %i[id name]
  end

  def show
    render json: @country
  end

  private

  def set_country
    @country = Country.find(params[:id])
  end
end
