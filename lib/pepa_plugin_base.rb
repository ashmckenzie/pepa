class PepaPluginBase
  include Cinch::Plugin

  def execute *args
    @m = args[0]
  end
  
  def reply msg
    @m.reply msg, @m.user.nick
  end

  def notify msg
    User(@m.user.nick).send(msg)
  end
end

def pluralise count, options
  if count > 1
    options[0]
  else
    options[1]
  end
end  