class Api::BlocksController < ApplicationController
  before_action :authenticate!
  before_action :set_block, only: %i[update destroy]
  skip_before_action :verify_authenticity_token

  def create
    @block = Block.new(block_params)

    if @block.save
      render json: @block
    else
      render json: @block.errors, status: :bad_request
    end
  end

  def update
    if @block.update(block_params)
      render json: @block
    else
      render json: @block.errors, status: :bad_request
    end
  end

  def destroy
    @block.destroy!
    render json: @block
  end

  private

  def set_block
    @block = Block.find(params[:id])
  end

  def block_params
    params.require(:block).permit(:day_id, :title, :place, :place_info, :comment, :arriving_time, :leaving_time, images: [])
  end
end
