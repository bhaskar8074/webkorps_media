  // app/javascript/channels/chat.js
  import { createConsumer } from "@rails/actioncable"
  
  console.log("I am bhaskar")

  import consumer from "./consumer";

  document.addEventListener("DOMContentLoaded", function() {
    const chatForm = document.getElementById('chat-form');
    const messageInput = document.getElementById('message-input');
    const receiverId = document.getElementById('receiver-id').value;
    const messagesContainer = document.getElementById('messages');
    console.log(chatForm)

    if (chatForm) {
      const cable = createConsumer()
      const chatChannel = cable.subscriptions.create({ channel: "ChatChannel", room: `user_${receiverId}` }, {
        connected() {
          // Called when the subscription is ready for use on the server
          console.log(chatChannel);
          console.log("Connected to ChatChannel.");
        },

        disconnected() {
          // Called when the subscription has been terminated by the server
          // console.log("Disconnected from ChatChannel.");
        },

        received(data) {
          // Handle incoming messages here
          // messagesContainer.innerHTML += `<div class="self-start bg-gray-200 rounded-lg p-2">${data.message}</div>`;
        },

        send(message, receiverId) {
          console.log(receiverId)
          // Send the message and receiver ID to the server
          this.perform('send_message', { message, receiver_id: receiverId, room: `user_${receiverId}` });
        }
      });

      chatForm.addEventListener('submit', function(e) {
        e.preventDefault(); // Prevent the default form submission
        console.log("HI i AM SUBMIT event")

        const message = messageInput.value.trim();
        console.log(message);
        chatChannel.send({message, receiverId});

        if (message !== '') {
          // Send the message using ActionCable
          chatChannel.send({message, receiverId});

          // Clear the message input field
          messageInput.value = '';
        }
      });
    }
  });
