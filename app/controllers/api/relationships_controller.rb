class Api::RelationshipsController < ApplicationController
  before_action :authenticate!, only: %i[follow destroy]
  skip_before_action :verify_authenticity_token

  def following
    @relationship = Relationship.where(user_id: params[:id]).order(created_at: :desc)
    render json: @relationship, include: :follow
  end

  def followers
    @relationship = Relationship.where(follow_id: params[:id]).order(created_at: :desc)
    render json: @relationship, include: :user
  end

  def follow
    new_following = current_user.follow(params[:id])
    render json: new_following
  end

  def destroy
    old_following = current_user.unfollow(params[:id])
    render json: old_following
  end
end
