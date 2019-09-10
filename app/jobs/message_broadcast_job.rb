class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    if message.is_a?(ActiveRecord::Base)
      ActionCable.server.broadcast 'room_channel', message: render_message(message)
    else
      ActionCable.server.broadcast 'room_channel', id: message
    end
  end

  private

    def render_message(message)
      ApplicationController.renderer.render partial: 'messages/message', locals: { message: message }
    end
end
