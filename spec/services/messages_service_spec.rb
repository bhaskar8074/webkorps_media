# frozen_string_literal: true

RSpec.describe MessagesService do
  let!(:user) { User.create(email: 'user1@example.com', password: 'password') }
  let(:receiver) { User.create(email: 'user2@example.com', password: 'password') }

  describe '#get_messages' do
    it 'returns messages between the user and receiver' do
      Message.create(sender: user, receiver: receiver, content: 'Message 1')
      Message.create(sender: receiver, receiver: user, content: 'Message 2')

      params = { id: receiver.id }
      messages_service = MessagesService.new(user, params)

      returned_receiver, messages = messages_service.get_messages
      expect(returned_receiver).to eq(receiver)
      expect(messages.size).to eq(2)
      expect(messages[0].content).to eq('Message 1')
      expect(messages[1].content).to eq('Message 2')
    end
  end

  describe '#create_message' do
    it 'create_message' do
      params = { content: 'New message content', reciver_id: receiver.id }
      messages_service = MessagesService.new(user, ActionController::Parameters.new(params))

      expect do
        messages_service.create_message
      end.to change(Message, :count).by(1)
    end
  end

  describe '#create_message' do
    it 'creates a new message' do
      params = { content: 'New message content', receiver_id: receiver.id }
      messages_service = MessagesService.new(user, ActionController::Parameters.new(params))

      expect do
        messages_service.create_message
      end.to change(Message, :count).by(1)

      created_message = Message.last
      expect(created_message.content).to eq('New message content')
      expect(created_message.sender).to eq(user)
      expect(created_message.receiver).to eq(receiver)
    end
  end
end
