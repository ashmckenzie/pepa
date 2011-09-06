class Help < PepaPluginBase  
  match /help/
  
  def execute m
    super
    help
  end
  
  def info
    '!help - Show help'
  end
  
  def help
    reply 'Here is the plugins I know about: -'
    @bot.plugins.each do |plugin|
      reply plugin.info
    end
  end
end
