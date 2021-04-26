class Api::UsersController < ApplicationController
  before_action :authenticate!, only: %i[update update_current_user destroy_current_user reset_avatar]
  skip_before_action :verify_authenticity_token

  def show
    user = User.find(params[:id])
    user_json = user.as_json(only: %i[id name description])
    render json: user_json.merge(avatar_url: user.avatar_url)
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

  def update
    user = User.find(current_user.id)
    if user.update(user_params)
      render json: user, methods: [:avatar_url]
    else
      render json: user.errors, status: :bad_request
    end
  end

  def destroy
    user = User.find(current_user.id)
    user.destroy!
    render json: user
  end

  def me
    user = current_user.as_json(only: %i[id name email description])
    if current_user.avatar.attached?
      render json: user.merge(avatar_url: current_user.avatar_url)
    else
      render json: user
    end
  end

  def reset_avatar
    return unless current_user.avatar.attached?

    current_user.avatar.purge
    render json: current_user
  end

  private

  def user_params
    params.permit(:name, :email, :password, :description, :avatar)
  end
end
