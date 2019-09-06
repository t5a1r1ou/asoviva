# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, except: [:index]
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @post = Post.new
    @posts = current_user.posts
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

  def user_params
    if params[:user][:avatar] == ''
      params.require(:user).permit(:name, :gender, :profile)
    else
      params.require(:user).permit(:name, :gender, :profile, :avatar)
    end
  end
end
