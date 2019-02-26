class MovieChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "#{uuid}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def movies(message)
    ActionCable.server.broadcast "#{uuid}", message
  end
end
