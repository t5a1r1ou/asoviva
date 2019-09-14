# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, except: %i[index follows followers mutual_follow]
  before_action :authenticate_user!
  before_action :current_user!, only: %i[commented comments]

  def index
    @users = User.with_attached_avatar
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @post = Post.new
    @stocking_posts = @user.stocking_posts.includes(:user)
    @sent_comment_posts = @user.sent_comment_posts.includes(user: { avatar_attachment: :blob })
  end

  def follows
    @users = current_user.followings.with_attached_avatar
    respond_to do |format|
      format.js
    end
  end

  def followers
    @users = current_user.followers.with_attached_avatar
    respond_to do |format|
      format.js
    end
  end

  def mutual_follow
    @users = current_user.mutual_followers
    respond_to do |format|
      format.js
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_url(@user), notice: "#{@user.name}のプロフィールを更新しました!"
    else
      render :edit
    end
  end

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
