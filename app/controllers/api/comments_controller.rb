class Api::CommentsController < ApplicationController
  before_action :authenticate!, only: %i[create update destroy]
  before_action :set_comment, only: %i[update destroy]
  skip_before_action :verify_authenticity_token

  include Pagination

  def show
    comments = Article.find(params[:id]).comments.includes(:user).page(params[:page]).per(20).order(created_at: :desc)
    pagenation = resources_with_pagination(comments)
    @comments = Comment.change_to_json(comments)
    render json: { comments: @comments, kaminari: pagenation }
  end

  def create
    @comment = current_user.comments.build(comment_params)

    if @comment.save
      render json: @comment
    else
      render json: @comment.errors, status: :bad_request
    end
  end

  def update
    if @comment.update(comment_update_params)
      render json: @comment
    else
      render json: @comment.errors, status: :bad_request
    end
  end

  def destroy
    @comment.destroy!
    render json: @comment
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:article_id, :body)
  end

  def comment_update_params
    params.require(:comment).permit(:body)
  end
end
