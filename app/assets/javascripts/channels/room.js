App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    var messages = document.querySelector("#messages");
    var tempEl = document.createElement('div');
    tempEl.innerHTML = data['message'];
    return messages.appendChild(tempEl.firstElementChild);
  },

  speak: function(message) {
    return this.perform('speak', {
      message: message
    });
  }
}, document.addEventListener('DOMContentLoaded', function() {
  message_input = document.querySelector('input[data-behavior="room_speaker"]')
  message_input.addEventListener('keypress', function(e) {
    if (e.keyCode === 13) {
      App.room.speak(e.target.value)
      e.target.value = ''
      e.preventDefault()
    }
  });
}));
