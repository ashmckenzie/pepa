var socket;
var socket_connected = false;
var content = $('#events');

function receive_events() {
  socket = io.connect(location.href, { 'force new connection': true });

  socket.on('connect', function () {
    socket_connected = true;
  });

  socket.on('disconnect', function () {
    socket_connected = false;
  });

  socket.on('message', function (message) {
    json = jQuery.parseJSON(message);
    content.prepend(Mustache.to_html($('#event').html(), json.event));
  });
}

function pause_events() {
  socket.disconnect();
  delete socket;
}