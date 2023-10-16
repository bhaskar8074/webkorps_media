# frozen_string_literal: true

# messages controller
class MessagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @receiver = User.find(params[:id])
    @messages = Message.where(
      '(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)',
      current_user.id, @receiver.id, @receiver.id, current_user.id
    ).order(created_at: :asc)
  end

  def create
    @message = current_user.sent_messages.build(message_params)

    return unless @message.save

    redirect_to message_path(@message.receiver)
  end

  def destroy; end

  private

  def message_params
    params.permit(:content, :receiver_id)
  end
end
