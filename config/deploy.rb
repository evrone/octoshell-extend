set :rbenv_ruby_version, "2.0.0-p0"
set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH",
  'RBENV_VERSION' => rbenv_ruby_version
}
set :bundle_flags, "--deployment --quiet --binstubs --shebang ruby-local-exec"
set :rake, "bin/rake"

require 'bundler/capistrano'

set :application, "octoshell-extend"
set :domain, "evrone@v1.parallel.ru"
set :repository,  "git@github.com:evrone/octoshell-extend.git"
set :branch, "master" # production
set :use_sudo, false
set :deploy_to, "/var/www/#{application}"
set :keep_releases, 3
set :scm, :git
set :rack_env, 'production'
set :ssh_options, { forward_agent: true }

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
  desc "Restart Unicorn and Resque"
  task :restart do
    run "sv restart ~/services/octoshell_extend_unicorn"
  end
  
  desc "Make symlinks"
  task :make_symlinks, :roles => :app, :except => { :no_release => true } do
    # Ставим симлинк на конфиги и загрузки
    run "rm -f #{latest_release}/config/database.yml"
    run "ln -s #{deploy_to}/shared/configs/database.yml #{latest_release}/config/database.yml"
    run "ln -s #{deploy_to}/shared/keys/private #{latest_release}/config/keys/private"
  end
end

after 'deploy:finalize_update', 'deploy:make_symlinks'
