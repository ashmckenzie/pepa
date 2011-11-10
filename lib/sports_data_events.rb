class SportsDataEvents
  def initialize(bot)
    @bot = bot 
  end 

  def start
    while true
      $redis.subscribe('sd') do |on|
        on.message do |channel, msg|
          data = JSON.parse(msg)
          @bot.dispatch(:sport_event, nil, data)
          puts "##{channel} - #{data['msg']}"
        end 
      end 
    end 
  end 
end
