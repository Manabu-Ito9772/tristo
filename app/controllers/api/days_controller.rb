class Api::DaysController < ApplicationController
  before_action :authenticate!
  skip_before_action :verify_authenticity_token

  def create
    day = Day.new(day_params)

    if day.save
      render json: day
    else
      render json: day.errors, status: :bad_request
    end
  end

  def destroy
    day = Day.find(params[:id])

    day.destroy!
    render json: day
  end

  private

  def day_params
    params.require(:day).permit(:article_id)
  end
end
