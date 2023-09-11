class MessagesController < ApplicationController
    before_action :authenticate_user!

    def show
        @receiver = User.find(params[:id])
        @messages = Message.where(
          "(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)",
          current_user.id, @receiver.id, @receiver.id, current_user.id
        ).order(created_at: :asc)
        p "******    #{@messages.inspect}"
    end

    def create
      # p "********************  ** *** ***Params: #{params.inspect}"
      @message = current_user.sent_messages.build(message_params)
      # p "**********    ** #{@message.save}"



      if @message.save
        redirect_to message_path(@message.receiver)
      else
        p "error"
      end
    end

    def destroy
    end

    private

    def message_params
      params.permit(:content, :receiver_id) 
    end
end
