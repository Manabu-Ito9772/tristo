class Api::CountriesController < ApplicationController
  def index
    countries = Country.all.order(order: :asc)
    render json: countries, only: %i[id name]
  end

  def show
    country = Country.find(params[:id])
    render json: country
  end
end
