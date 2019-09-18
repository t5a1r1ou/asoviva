# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, except: %i[index create search result form]

  def index
    @post = Post.new
    @q = Post.ransack(params[:q])
    @posts = @q.result.includes(user: { avatar_attachment: :blob }).includes(image_attachment: :blob).page(params[:page]).per(Settings.page)
  end

  # rubocop:disable Metrics/AbcSize
  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      @post.image.attach(io: @post.create_ogp, filename: "#{@post.name}_image.png")
      redirect_to posts_url, notice: "#{@post.name}に行く予定を登録しました！"
    else
      @q = Post.ransack(params[:q])
      @posts = @q.result.includes(user: { avatar_attachment: :blob }).includes(image_attachment: :blob).page(params[:page]).per(Settings.page)
      render :index
    end
  end
  # rubocop:enable Metrics/AbcSize

  def show
    @comment = Comment.new
    @tweet_url = "https://twitter.com/intent/tweet?url=#{request.url}&text=#{@post.name}に一緒に行く人募集。#{@post.description}"
  end

  def edit; end

  def update
    if @post.update(post_params)
      @post.image.attach(io: @post.create_ogp, filename: "#{@post.name}_image.png")
      redirect_to posts_url, notice: "#{@post.name}に行く予定を更新しました！"
    else
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
    params.require(:post).permit(:name, :description, :area, :count, :date, :category, :image)
  end
end
