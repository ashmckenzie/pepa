class Ping < PepaPluginBase  
  match /ping (.+)/
  
  def execute m, query
    super
    reply "#{ping(query)}"
  end
  
  def info
    '!ping <host> - Pings a host and returns either up or down'
  end
  
  def ping host
    require 'net/ping'
    begin
      p = Net::Ping::External.new(host)
      if p.ping?
        resp = "#{host} is up"
      else
        resp = "#{host} appears down"
      end
    rescue Exception => e
      resp = 'Something went wrong.  Is host correct ?'
    end
    resp
  end
end
