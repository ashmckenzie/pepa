class PepaPluginBase
  include Cinch::Plugin

  def execute *args
    @m = args[0]
  end
  
  def reply msg
    @m.reply "#{@m.user.nick}: #{msg}"
  end
end

def pluralise count, options
  if count > 1
    options[0]
  else
    options[1]
  end
end  