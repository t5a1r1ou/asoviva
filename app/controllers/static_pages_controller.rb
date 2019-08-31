class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to posts_url
    end
  end
end
