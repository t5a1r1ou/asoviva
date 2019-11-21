# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      redirect_to post_path(params[:post_id]), notice: 'リクエストの送信が完了しました'
    else
      @post = Post.find(params[:post_id])
      flash.now[:alert] = 'コメントは15文字以内で入力してください'
      render 'posts/show'
    end
  end

  def destroy; end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
