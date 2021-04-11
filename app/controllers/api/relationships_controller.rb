class Api::RelationshipsController < ApplicationController
  before_action :authenticate!, only: %i[follow destroy get_following_ids]
  skip_before_action :verify_authenticity_token

  include Pagination

  def following
    relationships = Relationship.includes(:follow).where(user_id: params[:id]).page(params[:page]).per(20).order(created_at: :desc)
    pagenation = resources_with_pagination(relationships)
    @relationships = Relationship.change_following_to_json(relationships)
    render json: { relationships: @relationships, kaminari: pagenation }
  end

  def followers
    relationships = Relationship.includes(:user).where(follow_id: params[:id]).page(params[:page]).per(20).order(created_at: :desc)
    pagenation = resources_with_pagination(relationships)
    @relationships = Relationship.change_followers_to_json(relationships)
    render json: { relationships: @relationships, kaminari: pagenation }
  end

  def follow
    new_following = current_user.follow(params[:id])
    render json: new_following
  end

  def destroy
    old_following = current_user.unfollow(params[:id])
    render json: old_following
  end

  def count
    user = User.find(params[:id])
    following = user.followings.count
    followers = user.followers.count
    render json: { following: following, followers: followers }
  end

  def get_following_ids
    followings = current_user.followings
    following_ids = followings.to_json(only: :id)
    render json: following_ids
  end
end
