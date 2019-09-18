# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.new
  end

  def result
    @events = Event.new
    @events.get_data(search_params[:area])
    @post = Post.new
    respond_to do |format|
      format.js
    end
  end

  def form
    @post = Post.new
  end

  private

  def search_params
    params.permit(:area)
  end
end
