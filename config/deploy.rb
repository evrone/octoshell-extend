require 'bundler/capistrano'
require "rvm/capistrano"
set :rvm_type, :system
set :rvm_ruby_string, '1.9.3@octoshell-expand'

set :application, "octoshell-expand"
set :domain, "evrone@v1.parallel.ru"
set :repository,  "git@github.com:evrone/octoshell-extend.git"
set :branch, "master"
set :use_sudo, false
set :deploy_to, "/var/www/#{application}"
set :keep_releases, 3
set :scm, :git
set :unicorn_remote_config, '/var/www/msu/current/config/unicorn.rb'
set :unicorn_bin, 'bundle exec unicorn_rails'

role :app, domain
role :web, domain
role :db,  domain, :primary => true

# set :whenever_command, "bundle exec whenever"
# require "whenever/capistrano"

namespace :deploy do
  desc "Restart Unicorn"
  task :restart do
    run "kill -QUIT `cat /tmp/unicorn.msu.pid`" rescue nil
    run "cd #{current_path} && #{unicorn_bin} -c #{unicorn_remote_config} -E #{rack_env} -D"
  end
  
  desc "Make symlinks"
  task :make_symlinks, :roles => :app, :except => { :no_release => true } do
    # Ставим симлинк на конфиги и загрузки
    run "rm -f #{latest_release}/config/database.yml"
    run "ln -s #{deploy_to}/shared/configs/database.yml #{latest_release}/config/database.yml"
  end
end

after 'deploy:finalize_update', 'deploy:make_symlinks'
