class CIBase < PepaPluginBase
  
  def config
    @config ||= YAML.load_file('./config.d/ci.yaml')
  end
    
  private
    
  def ci_url
    "#{config['url']}#{config['path']}"
  end
  
  def job_url job
    "#{config['url']}/job/#{job['name']}/api/json"
  end
  
  def build_job job
    RestClient.get "#{config['url']}/job/#{job}/build?delay=0sec"
  end
  
  def get_failed_job_url job
    json = JSON.parse(RestClient.get(job_url(job)))
    "#{job['name']} #{json['lastFailedBuild']['url'].chomp('/')}/console"
  end
  
  def excluded_job? job_name
    return false if config['exclude_jobs'].nil? or !config.include? 'exclude_jobs'
    config['exclude_jobs'].include? job_name
  end
end