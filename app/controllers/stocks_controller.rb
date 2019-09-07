# frozen_string_literal: true

class StocksController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @stock = current_user.stocks.build(post_id: params[:post_id])
    @stock.save
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @stock = current_user.stocks.find_by(post_id: params[:post_id])
    @stock.destroy
    respond_to do |format|
      format.html
      format.js
    end
  end
end
