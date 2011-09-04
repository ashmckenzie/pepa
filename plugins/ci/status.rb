class CIStatus < PepaPluginBase  
  match /ci:status/
  
  def initialize arg
    super
    @config = YAML.load_file('./config.d/ci.yaml')
  end

  def execute m
    super
    reply status
  end

  def status
    red_jobs = []
    json = JSON.parse RestClient.get @config['url']
    json['jobs'].each do |job|
      if job['color'] == 'red' and !excluded_job? job['name']
        red_jobs << job
      end
    end
    
    if red_jobs.empty?
      'All good.'
    else
      red_jobs.collect { |j| 
        "#{@config['url']}\/job/#{j['name']}"
      }.join(', ') + ' ' + pluralise(red_jobs.count, [ 'are', 'is' ]) + ' red.'
    end
  end
  
  private
  
  def excluded_job? job_name
    return false if @config['exclude_jobs'].nil? or !@config.include? 'exclude_jobs'
    @config['exclude_jobs'].include? job_name
  end
end