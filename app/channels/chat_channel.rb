# frozen_string_literal: true

# chat channel
class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_for "1"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
