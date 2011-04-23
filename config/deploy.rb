require 'bundler/capistrano'

set :user, 'tmayfield'
set :domain, 'zen-hacking.com'
set :application, 'goathub'

# file paths
set :repository,   "#{user}@#{domain}:/opt/git/#{application}" 
set :deploy_to,    "/var/www/goathub" 
set :config_path,  "/opt/git/goathub-config"

# bundler config
set :bundle_flags, "--deployment --quiet"

# distribute your applications across servers (the instructions below put them
# all on the same server, defined above as 'domain', adjust as necessary)
role :app, domain
role :web, domain
role :db, domain, :primary => true

# you might need to set this if you aren't seeing password prompts
default_run_options[:pty] = true

# As Capistrano executes in a non-interactive mode and therefore doesn't cause
# any of your shell profile scripts to be run, the following might be needed
# if (for example) you have locally installed gems or applications.  Note:
# this needs to contain the full values for the variables set, not simply
# the deltas.
# default_environment['PATH']='/usr/local/bin:/usr/bin:/bin'
default_environment['GEM_PATH']='/home/tmayfield/.gem:/usr/lib/ruby/gems/1.8'

# miscellaneous options
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false

namespace :deploy do
  desc "cause Passenger to initiate a restart"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt" 
  end

  desc "symlink in database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{config_path}/database.yml #{release_path}/config/database.yml"
  end
end

after "deploy:update_code", :bundle_install
after 'deploy:update_code', 'deploy:symlink_db'

desc "install the necessary prerequisites"
task :bundle_install, :roles => :app do
  run "cd #{release_path} && bundle install"
end
