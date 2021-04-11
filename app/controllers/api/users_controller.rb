class Api::UsersController < ApplicationController
  before_action :authenticate!, only: %i[update_current_user destroy_current_user]
  skip_before_action :verify_authenticity_token

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      token = @user.create_tokens
      render json: { token: token }
    else
      render json: @user.errors, status: :bad_request
    end
  end

  def me
    render json: current_user, include: {}
  end

  def update_current_user
    if current_user.update(user_params)
      render json: current_user
    else
      render json: current_user.errors, status: :bad_request
    end
  end

  def destroy_current_user
    current_user.destroy!
    render json: current_user
  end

  private

  def user_params
    params.permit(:name, :email, :description, :password)
  end
end
