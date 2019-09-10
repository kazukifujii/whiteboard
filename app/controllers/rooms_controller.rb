class RoomsController < ApplicationController
  def show
    @messages = Message.all.order(:id)
  end
end
