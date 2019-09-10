# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, except: :index
  before_action :authenticate_user!
  before_action :current_user!, only: %i[commented comments]

  def index
    @users = User.with_attached_avatar
  end

  def show
    @post = Post.new
    @stocking_posts = @user.stocking_posts.includes(:user)
  end

  def follows
    @users = @user.followings
  end

  def followers
    @users = @user.followers
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_url(@user), notice: "#{@user.name}のプロフィールを更新しました!"
    else
      render :edit
    end
  end

  def commented
    @posts = Post.where(user_id: params[:id])
  end

  def comments; end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def current_user!
    redirect_to posts_url, alert: 'アクセス権限がありません' if current_user.id != params[:id].to_i
  end

  def user_params
    if params[:user][:avatar] == ''
      params.require(:user).permit(:name, :gender, :profile)
    else
      params.require(:user).permit(:name, :gender, :profile, :avatar)
    end
  end
end
