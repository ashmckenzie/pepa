$(document).ready(function() {
  var socket = io.connect('http://localhost');
  var content = $('#events');

  socket.on('message', function(message){
    json = jQuery.parseJSON(message);
    content.prepend(
      '<div class="event">' + 
        '<div class="event-type ' + json.event.type + '"></div>' +
        '<div class="event-message">' + 
        json.event.message + 
        '<div class="event-timestamp">' + json.event.timestamp + '</div>' +
        '</div>' + 
      '</div>'
    );
  });
});