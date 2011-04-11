require 'jobs'
require 'resque'
require 'resque_scheduler'
Resque.schedule = YAML.load_file(File.join(File.dirname(__FILE__), '../resque_jobs.yml'))


