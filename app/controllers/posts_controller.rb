# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_post, except: %i[index create]

  def index
    @post = Post.new
    @q = Post.ransack(params[:q])
    @posts = @q.result.page(params[:page]).includes(user: { avatar_attachment: :blob }).per(10)
  end

  # rubocop:disable Metrics/AbcSize
  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_url, notice: "#{@post.name}に行く予定を登録しました！"
    else
      flash.now[:alert] = 'エリア、カテゴリが初期化されています。ご注意ください'
      @q = Post.ransack(params[:q])
      @posts = @q.result.page(params[:page]).includes(user: { avatar_attachment: :blob }).per(10)
      render :index
    end
  end
  # rubocop:enable Metrics/AbcSize

  def show
    @comment = Comment.new
  end

  def edit
    flash.now[:alert] = 'エリア、カテゴリが初期化されています。ご注意ください'
  end

  def update
    if @post.update(post_params)
      redirect_to posts_url, notice: "#{@post.name}に行く予定を更新しました！"
    else
      flash.now[:alert] = 'エリア、カテゴリが初期化されています。ご注意ください'
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: "#{@post.name}に行く予定を削除しました"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:name, :description, :area, :count, :date, :category)
  end
end
