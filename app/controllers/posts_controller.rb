class PostsController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.page(params[:page]).per(9)
  end

  def create
    post = Post.new(post_params)
    if post.save!
      redirect_to posts_url, notice: "あなたの「#{post.name}に行きたい！」を登録しました！"
    else
      render :index
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
    redirect_to posts_url, notice: "#{post.name}に行く予定を更新しました！"
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_url, notice: "#{post.name}にいく予定を削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:name, :description, :area, :count, :deadline)
  end
end