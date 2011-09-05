class Help < PepaPluginBase  
  match /help/
  
  def execute m
    super
    reply help
  end
  
  def info
    '!help - Show help'
  end
  
  def help
    s = [ 'Here is the plugins I know about: -' ]
    @bot.plugins.each do |plugin|
      s << plugin.info
    end
    s.join("\n")
  end
end
