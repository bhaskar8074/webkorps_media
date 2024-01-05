# frozen_string_literal: true

# messages controller
class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_messages_services

  def show
    @receiver, @messages = @messages_service.fetch_messages
  end

  def create
    @message = @messages_service.create_message

    return unless @message.valid?

    ChatChannel.broadcast_to(@message.receiver, {
                               message: @message
                             })
    redirect_to message_path(@message.receiver)
  end

  def destroy; end

  private

  def set_messages_services
    @messages_service = MessagesService.new(current_user, params)
  end
end
