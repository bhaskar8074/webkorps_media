# frozen_string_literal: true

# messages services
class MessagesService
  def initialize(user, params)
    @user = user
    @params = params
  end

  def fetch_messages
    @receiver = receiver
    @messages = Message.where(
      '(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)',
      @user.id, @receiver.id, @receiver.id, @user.id
    ).order(created_at: :asc)
    [@receiver, @messages]
  end

  def receiver
    @receiver = User.find(@params[:id])
  end

  def create_message
    @message = @user.sent_messages.build(message_params)
    @message.save
    @message
  end

  private

  def message_params
    @params.permit(:content, :receiver_id)
  end
end
