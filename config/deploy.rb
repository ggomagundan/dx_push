# -*- encoding : utf-8 -*-
# config valid only for Capistrano 3.1
lock '3.1.0'

require 'unicorn'

#set :whenever_command, "bundle exec whenever"
#require "whenever/capistrano"

set :application, 'dx_push'
#require "whenever/capistrano"


# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
 set :scm, :git

#set :repo_url, 'git@github.com:YelloMobile/dx_push.git'
set :repo_url, 'git@github.com:ggomagundan/dx_push.git'
# Default value for :format is :pretty
#set :branch,  'master'
set :deploy_via, :remote_cache
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
set :default_env, { path: "/root/.rbenv/versions/2.1.0/lib/ruby/gems:/root/.rbenv/versions/2.1.0/bin:$PATH" }
#set :current_deploy_path, "/geuinea_pig/priday/current"

# Default value for keep_releases is 5
# set :keep_releases, 5


set :ssh_options, { :forward_agent => true}
set :user, "root"
set :password, "dPffhdPffh1!"


namespace :whenever do
  task :start do 
    on roles(:app) do
      execute("cd #{fetch :current_deploy_path}")
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, 'exec whenever --update-crontab'
        end
      end
    end
  end
end

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

 before 'deploy:assets:precompile', :link_assets
 task :link_assets do
    on roles(:app), :roles => :app, :except => { :no_release => true } do
      execute("ln -fs #{shared_path}/database.yml #{release_path}/config/database.yml")
    end
  end


#before 'deploy:publishing', :kill_unicorns

  task :make_unicorn do
    on roles(:app), in: :sequence, wait: 3 do

      execute("cp #{shared_path}/unicorn.rb  #{fetch :current_deploy_path}/config/unicorn.rb")
      execute("if [ -f #{shared_path}/pids/unicorn.pid ]; then kill -s QUIT `cat #{shared_path}/pids/unicorn.pid`; fi")
      execute("cd #{fetch :current_deploy_path}")
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, 'exec unicorn -D -c config/unicorn.rb -E production'
        end
      end
    end
  end


#  desc "Update the crontab file"
#  task :update_crontab do #, :roles => :db do
#    on roles(:app), in: :sequence, wait: 3 do
#      execute("cd #{release_path} && bundle exec whenever --update-crontab #{application}")
#    end
#  end

  after 'deploy:publishing', :make_unicorn
  after 'deploy:finishing', 'whenever:start'

end
