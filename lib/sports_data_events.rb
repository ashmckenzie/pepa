require_relative 'redis_connect'

class SportsDataEvents
  def initialize(bot)
    @bot = bot 
  end 

  def start
    while true
      $redis.subscribe($config['redis']['channel']) do |on|
        on.message do |channel, msg|
          data = JSON.parse(msg)
          @bot.dispatch(:sport_event, nil, data)
          puts "##{channel} - #{data.to_s}"
        end 
      end 
    end 
  end 
end
