var socketio = require('socket.io'),
    redis = require('redis'),
    path = require('path'),
    yaml = require('yaml'),
    fs = require('fs'); 

var $ = require('jquery'); 

var config = load_config(path.resolve('..') + '/config.yaml')
var config_local = load_config(path.resolve('..') + '/config_local.yaml')

merge(config, config_local);

var app = require('http').createServer(handler)
  , io = require('socket.io').listen(app)
  , fs = require('fs')

app.listen(3000);

function handler (req, res) {
  fs.readFile(__dirname + '/public/index.html',
  function (err, data) {
    if (err) {
      res.writeHead(500);
      return res.end('Error loading index.html');
    }

    res.writeHead(200);
    res.end(data);
  });
}

var client = redis.createClient(config.redis.port, config.redis.host);

io.sockets.on('connection', function (socket) {
    client.on("message", function (channel, message) {
    socket.emit('message', message);
  });
});

client.subscribe(config.redis.channel);

function load_config(config) {
  return yaml.eval(fs.readFileSync(config).toString());
}

function merge(obj1, obj2) {

  for (var p in obj2) {
    try {
      // Property in destination object set; update its value.
      if ( obj2[p].constructor==Object ) {

        obj1[p] = merge(obj1[p], obj2[p]);

      } else if ( obj2[p].constructor==Array ) {

        /* I'd like to merge Array's too please */

        obj1[p] = obj2[p].concat(obj1[p]);

      } else {
        obj1[p] = obj2[p];

      }

    } catch(e) {
      // Property in destination object not set; create it and set its value.
      obj1[p] = obj2[p];

    }
  }

  return obj1;
}