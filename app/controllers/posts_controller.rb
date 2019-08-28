class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, except: [:index, :show]

  def index
    @post = Post.new
    @posts = Post.page(params[:page]).per(9)
    @user = User.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_url, notice: "#{@post.name}に行く予定を登録しました！"
    else
      @posts = Post.page(params[:page]).per(9)
      flash.now[:alert] = 'エリア、カテゴリが初期化されています。ご注意ください'
      render :index
    end
  end

  def show
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
    redirect_to posts_url, notice: "#{post.name}に行く予定を削除しました"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:name, :description, :area, :count, :deadline, :category)
  end
end
