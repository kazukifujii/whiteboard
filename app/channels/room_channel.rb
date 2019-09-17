class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
  end

  def speak(data)
    StickyNote.create! content: data['sticky_note']
  end

  def remove(data)
    StickyNote.destroy data['sticky_note']
  end
end
