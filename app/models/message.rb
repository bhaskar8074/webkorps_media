class Message < ApplicationRecord
    belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
    belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'

    def sent_by_current_user?(current_user)
        sender_id == current_user.id
      end
end
