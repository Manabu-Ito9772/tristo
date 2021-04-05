class Api::CommentsController < ApplicationController
  before_action :authenticate!, only: %i[create update destroy]
  before_action :set_comment, only: %i[update destroy]
  skip_before_action :verify_authenticity_token

  def show
    comments = Article.find(params[:id]).comments.order(created_at: :asc)
    render json: comments
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
