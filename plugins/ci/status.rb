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
  
  def info
    "!ci:status - Display job status for #{ci_url}"
  end
  
  def status
    red_jobs = []
    json = JSON.parse RestClient.get(ci_url)
    json['jobs'].each do |job|
      if job['color'] == 'red' and !excluded_job? job['name']
        red_jobs << job
      end
    end
    
    if red_jobs.empty?  
      'All jobs are green.'
    else
      string = [ "The following job#{pluralise(red_jobs.count, [ 's are', ' is' ])} red: -"]
      red_jobs.each { |job| string << get_failed_job_url(job) }
      string.join("\n")
    end
  end
  
  private
  
  def ci_url
    "#{@config['url']}#{@config['path']}"
  end
  
  def job_url job
    "#{@config['url']}\/job/#{job['name']}/api/json"
  end
  
  def get_failed_job_url job
    json = JSON.parse(RestClient.get(job_url(job)))
    "#{job['name']} #{json['lastFailedBuild']['url'].chomp('/')}/console"
  end
  
  def excluded_job? job_name
    return false if @config['exclude_jobs'].nil? or !@config.include? 'exclude_jobs'
    @config['exclude_jobs'].include? job_name
  end
end