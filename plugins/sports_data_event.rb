class SportsDataEvent
  include Cinch::Plugin

  listen_to :sport_event

  def listen(m, data)
    Channel("#sd").send data['msg']
  end
end
