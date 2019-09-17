class RoomsController < ApplicationController
  def show
    @sticky_notes = StickyNote.all.order(:id)
  end
end
