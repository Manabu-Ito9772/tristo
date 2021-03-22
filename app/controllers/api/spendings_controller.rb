class Api::SpendingsController < ApplicationController
  before_action :set_spending, only: %i[show update destroy]
  skip_before_action :verify_authenticity_token

  def create
    @spending = Spending.new(spending_params)

    if @spending.save
      render json: @spending
    else
      render json: @spending.errors, status: :bad_request
    end
  end

  def update
    if @spending.update(spending_params)
      render json: @spending
    else
      render json: @spending.errors, status: :bad_request
    end
  end

  def destroy
    @spending.destroy!
    render json: @spending
  end

  private

  def set_spending
    @spending = Spending.find(params[:id])
  end

  def spending_params
    params.require(:spending).permit(:block_id, :genre, :description, :cost)
  end
end
