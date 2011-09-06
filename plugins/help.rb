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
    notify 'Here is the plugins I know about: -'
    @bot.plugins.each do |plugin|
      notify plugin.info
    end
  end
end