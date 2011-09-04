module CI
  class Status < PepaPluginBase  
    match /ci:status/
  
    def execute m
      super
      reply status
    end
  
    def status
      'ci:status'
    end
  end
end