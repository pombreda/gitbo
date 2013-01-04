set :deploy_to, "/home/#{ user }/#{ application }/staging"
set :rails_env, "staging"

namespace :deploy do
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml /home/#{ user }/#{ application }/staging/config/database.yml"
    run "ln -nfs #{shared_path}/config/application.yml /home/#{ user }/#{ application }/staging/config/application.yml"
    run "ln -nfs #{shared_path}/config/initializers/omniauth.rb /home/#{ user }/#{ application }/staging/config/initializers/omniauth.rb"
    run "ln -nfs #{shared_path}/config/environments/production.rb /home/#{ user }/#{ application }/staging/config/environments/production.rb"
  end
end