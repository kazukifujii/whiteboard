class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
  end

  def speak(data)
    # ActionCable.server.broadcast 'room_channel', message: data['message']
    Message.create! content: data['message']
  end

  def delete(data)
    Message.destroy data['message']
  end
end
