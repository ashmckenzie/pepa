class Ping < PepaPluginBase  
  match /ping (.+)/
  
  def execute m, query
    super
    ping query
  end
  
  def info
    '!ping <host> - Pings a host and returns either up or down'
  end
  
  def ping host
    require 'net/ping'
    begin
      p = Net::Ping::External.new(host)
      if p.ping?
        reply "#{host} is up"
      else
        reply "#{host} appears down"
      end
    rescue Exception => e
      reply 'Something went wrong.  Is host correct ?'
    end
  end
end
