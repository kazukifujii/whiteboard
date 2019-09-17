class StickyNoteBroadcastJob < ApplicationJob
  queue_as :default

  def perform(sticky_note)
    if sticky_note.is_a?(ActiveRecord::Base)
      ActionCable.server.broadcast 'room_channel', sticky_note: render_sticky_note(sticky_note)
    else
      ActionCable.server.broadcast 'room_channel', id: sticky_note
    end
  end

  private

    def render_sticky_note(sticky_note)
      ApplicationController.renderer.render partial: 'sticky_notes/sticky_note', locals: { sticky_note: sticky_note }
    end
end
