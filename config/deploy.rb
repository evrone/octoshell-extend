require 'bundler/capistrano'
require "rvm/capistrano"
require 'capistrano-resque'

set :rvm_type, :system
set :rvm_ruby_string, '1.9.3@octoshell-extend'

set :application, "octoshell-extend"
set :domain, "evrone@v1.parallel.ru"
set :repository,  "git@github.com:evrone/octoshell-extend.git"
set :branch, "master"
set :use_sudo, false
set :deploy_to, "/var/www/#{application}"
set :keep_releases, 3
set :scm, :git
set :unicorn_remote_config, '/var/www/octoshell-extend/current/config/unicorn.rb'
set :unicorn_bin, 'bundle exec unicorn'
set :rack_env, 'production'
set :ssh_options, { forward_agent: true }

role :app, domain
role :web, domain
role :db,  domain, :primary => true
role :resque_worker, domain

before "deploy", "deploy:add_ssh_key"
before "deploy:migrations", "deploy:add_ssh_key"

# set :whenever_command, "bundle exec whenever"
# require "whenever/capistrano"

require 'capistrano-unicorn'

after "deploy:restart", "resque:restart"

namespace :deploy do
  task :add_ssh_key do
    run "ssh-add /home/evrone/.ssh/octoshell-extend"
  end
  
  task :restart do
  end
  
  desc "Make symlinks"
  task :make_symlinks, :roles => :app, :except => { :no_release => true } do
    # Ставим симлинк на конфиги и загрузки
    run "rm -f #{latest_release}/config/database.yml"
    run "ln -s #{deploy_to}/shared/configs/database.yml #{latest_release}/config/database.yml"
  end
end

after 'deploy:finalize_update', 'deploy:make_symlinks'
