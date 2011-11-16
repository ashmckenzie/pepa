var socket;
var socket_connected = false;
var content = $('#events');

function check_events(link) {
  if (socket_connected) {
    close_socket();
    $(link).text('show events');
  } else {
    open_socket();
    $(link).text('pause events');
  } 
}

function open_socket() {
  socket = io.connect('http://127.0.0.1:3001', { 'force new connection': true });

  socket.on('connect', function () {
    socket_connected = true;
  });

  socket.on('disconnect', function () {
    socket_connected = false;
  });

  socket.on('message', function (message) {
    json = jQuery.parseJSON(message);

    var html = Mustache.to_html($('#event').html(), json.event);
    content.prepend(html);

    /*
    content.prepend(html);
      '<div class="event">' + 
        '<div class="event-type ' + json.event.type + '"></div>' +
        '<div class="event-message">' + 
        json.event.message + 
        '<div class="event-timestamp">' + json.event.timestamp + '</div>' +
        '</div>' + 
      '</div>'
    );
    */
  });
}

function close_socket() {
  socket.disconnect();
  delete socket;
}

$(document).ready(function() {
  $('a#pause-events').click(function() { check_events(this); });
  open_socket();
});