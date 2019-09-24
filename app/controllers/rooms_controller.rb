# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @messages = Message.all
  end
end
