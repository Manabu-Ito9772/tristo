class Api::CountriesController < ApplicationController
  before_action :set_country, only: %i[show]

  def index
    @countries = Country.all
    render json: @countries
  end

  def show
    render json: @country
  end

  private

  def set_country
    @country = Country.find(params[:id])
  end
end
