class CIStatus < CIBase  
  match /ci:status/
      
  def execute m
    super
    status
  end

  def info
    "!ci:status - Display job status for #{ci_url}"
  end
    
  def status
    reply 'Retrieving CI jobs...'
    red_jobs = []
    json = JSON.parse RestClient.get(ci_url)
    json['jobs'].each do |job|
      if job['color'] == 'red' and !excluded_job? job['name']
        red_jobs << job
      end
    end
    
    if red_jobs.empty?  
      reply 'All jobs are green.'
    else
      reply "The following job#{pluralise(red_jobs.count, [ 's are', ' is' ])} red: -"
      red_jobs.each { |job| reply get_failed_job_url(job) }
    end
  end  
end