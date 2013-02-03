worker_processes 3 # amount of unicorn workers to spin up
timeout 30
before_exec do |server| 
  ENV["BUNDLE_GEMFILE"] = "~/Sites/epickone/Gemfile" 
end