# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "serp"
set :repo_url, "git@github.com:soreddysirish/serp.git"
set :deploy_to, "/var/www/serp_backend"
set :scm,:git
set :branch,"master"
set :keep_releases, 5
set :format, :pretty
set :log_level, :debug
set :pty, true 
set :linked_dirs, %w{pids log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :stages, %w(staging production development)
set :default_stage, "development"
set :ssh_options, {:forward_agent => true}
set :user,"ubuntu"
SSHKit.config.command_map[:rake] = "bundle exec rake"

# Force rails through bundle exec
SSHKit.config.command_map[:rails] = "bundle exec rails"

set :migration_role, 'app' # Defaults to 'db'
set :assets_roles, [:app] # Defaults to [:web]
# set :linked_files, %w(config/database.yml)

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # execute :rake,"db:create"
      # execute :rake,"db:migrate"
      # execute "chmod 777 -R #{release_path}/tmp"
      # execute "ln -s #{shared_path}/sitemaps/* #{release_path}/public"
      # execute "ln -s #{shared_path}/public/flight-schedule/* #{release_path}/public/flight-schedule"
      execute "sudo service apache2 restart"
      # execute "sudo whenever --update-cron"

      # execute "sudo touch #{File.join(current_path,'tmp','restart.txt')}"
    end
  end
  desc 'precompile assets'
  task :precompile do
    on roles(:app), in: :sequence, wait: 5 do
      with :environment=>:production do
        within release_path do
          rake "assets:clean"
          rake "assets:precompile NG_FORCE=true"
          # rake "assets:copy"
        end
      end
    end
  end
  after :finishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
  after :updated, 'deploy:precompile'

  # after :bundle, 'deploy:after_bundle'
end
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
