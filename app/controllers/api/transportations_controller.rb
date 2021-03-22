class Api::TransportationsController < ApplicationController
  before_action :set_transportation, only: %i[show update destroy]
  skip_before_action :verify_authenticity_token

  def create
    @transportation = Transportation.new(transportation_params)

    if @transportation.save
      render json: @transportation
    else
      render json: @transportation.errors, status: :bad_request
    end
  end

  def update
    if @transportation.update(transportation_params)
      render json: @transportation
    else
      render json: @transportation.errors, status: :bad_request
    end
  end

  def destroy
    @transportation.destroy!
    render json: @transportation
  end

  private

  def set_transportation
    @transportation = Transportation.find(params[:id])
  end

  def transportation_params
    params.require(:transportation).permit(:block_id, :means, :description, :cost)
  end
end
