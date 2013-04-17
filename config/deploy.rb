require 'bundler/capistrano' # for bundler support
require 'sidekiq/capistrano'
require 'capistrano/ext/multistage'

set :stages, %w(staging production)
set :default_stage, "staging"

set :application, "gitbo"
set :repository,  "git@github.com:flatiron-school/gitbo.git"

set :user, 'deploy'
set :deploy_to, "/home/#{ user }/#{ application }"
set :use_sudo, false

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

default_run_options[:pty] = true

role :web, "198.199.65.182"                          # Your HTTP server, Apache/etc
role :app, "198.199.65.182"                          # This may be the same as your `Web` server

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts
before "deploy:assets:precompile", "deploy:symlink_shared"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
    run "ln -nfs #{shared_path}/config/initializers/omniauth.rb #{release_path}/config/initializers/omniauth.rb"
    run "ln -nfs #{shared_path}/config/environments/production.rb #{release_path}/config/environments/production.rb"
  end

end
