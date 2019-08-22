class PostsController < ApplicationController
  def index
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.save!
    redirect_to posts_url, notice: "あなたの「#{post.name}に行きたい！」を登録しました！"
  end

  def show
  end


  def edit
  end

  private

  def post_params
    params.require(:post).permit(:name, :description, :area, :count, :deadline)
  end
end
