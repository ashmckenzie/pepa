class CIBuild < CIBase
  match /ci:build (.+)/
    
  def execute m, job
    super
    build job
  end
  
  def info
    "!ci:build <job> - Build a CI job #{ci_url}"
  end
  
  def build job
    reply "Attempting to build '#{job}'"
    begin
      build_job job
    rescue Exception => e
      reply "Are you sure '#{job}' exists ?"
    end
  end  
end