require 'bundler/capistrano'
require "rvm/capistrano"
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

before "deploy", "deploy:add_ssh_key"
before "deploy:migrations", "deploy:add_ssh_key"

# set :whenever_command, "bundle exec whenever"
# require "whenever/capistrano"

namespace :deploy do
  task :add_ssh_key do
    run "ssh-add /home/evrone/.ssh/octoshell-extend"
  end
  
  desc "Restart Unicorn"
  task :restart do
    run "kill -QUIT `cat /tmp/unicorn.octoshell-extend.pid`" rescue nil
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
