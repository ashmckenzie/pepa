class SportsDataEvent
  include Cinch::Plugin

  listen_to :sport_event

  def listen(m, data)
    Channel('#' + $config['irc']['rooms'].first).send data['event']['message']
  end
end
