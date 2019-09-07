# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :user_set, only: %i[create destroy]

  def create
    @follow = current_user.relationships.build(follower_id: params[:user_id])
    @follow.save
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @follow = current_user.relationships.find_by(follower_id: params[:user_id])
    @follow.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def user_set
    @user = User.find(params[:user_id])
  end
end
