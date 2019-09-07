class StocksController < ApplicationController
  def create
    stock = current_user.stocks.build(post_id: params[:post_id])
    stock.save
    redirect_to posts_path
  end

  def destroy
    stock = current_user.stocks.find_by(post_id: params[:post_id])
    stock.destroy
    redirect_to posts_path
  end
end
