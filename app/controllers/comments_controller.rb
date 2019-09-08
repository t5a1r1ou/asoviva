# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.save
    redirect_to post_path(params[:post_id]), notice: 'リクエストの送信が完了しました'
  end

  def destroy; end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
