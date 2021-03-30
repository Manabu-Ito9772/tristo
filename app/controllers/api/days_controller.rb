class Api::DaysController < ApplicationController
  before_action :authenticate!
  before_action :set_day, only: %i[show destroy]
  skip_before_action :verify_authenticity_token

  # def show
  #   render json: @day
  # end

  def create
    @day = Day.new(day_params)

    if @day.save
      render json: @day
    else
      render json: @day.errors, status: :bad_request
    end
  end

  def destroy
    @day.destroy!
    render json: @day
  end

  private

  def set_day
    @day = Day.find(params[:id])
  end

  def day_params
    params.require(:day).permit(:article_id)
  end
end
