var socketio = require('socket.io'),
    redis = require('redis'),
    path = require('path');

var utils = require('./utils.js');

var config = utils.load_config(path.resolve('..') + '/config.yaml')
var config_local = utils.load_config(path.resolve('..') + '/config_local.yaml')
utils.merge(config, config_local);

/* Express */

var express = require('express');
var app = express.createServer();

app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));  
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.get('/', function(req, res){
  res.render('index');
});

app.listen(config.node.port);

/* Redis PUB/SUB */

var io = require('socket.io').listen(app)
var client = redis.createClient(config.redis.port, config.redis.host);

io.configure(function() {
  io.set('log level', 3);
  io.set('force new connection', true);
});

io.sockets.on('connection', function (socket) {

  io.sockets.emit('user connected');

  socket.on('disconnect', function () {
    io.sockets.emit('user disconnected');
  });

  client.on("message", function (channel, message) {
    socket.emit('message', message);
  });
});

client.subscribe(config.redis.channel);
