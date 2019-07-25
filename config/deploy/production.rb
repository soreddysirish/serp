# set :branch, 'testing'
# set :stage, :development
# # Setting RAILS_ENV environment variable on server
# set :rails_env, :development
# set :deploy_to, '/var/www/flights-dynamic'
# set :normalize_asset_timestamps, %{public/images public/javascripts public/stylesheets}

# role :app, %w{ubuntu@54.169.165.81}

# set :ssh_options, {
#    forward_agent: true,
#    user: "ubuntu",
#    :keepalive => true,
#    :keepalive_interval => 3000
# }
# set :user, "ubuntu"
# # Force rake through bundle exec
# SSHKit.config.command_map[:rake] = "bundle exec rake"

# # Force rails through bundle exec
# SSHKit.config.command_map[:rails] = "bundle exec rails"



# production deploy server = 52.77.242.232

# testing deploy server = 54.169.165.81
# ssh ubuntu@54.169.165.81

# ssh ubuntu@52.77.242.232
# Dynamic F Production. = 52.77.242.232
# LB1 = 3.0.225.56	
# LB2 = 54.251.140.1  


# LB3 = 13.250.37.91
# LB4 = 3.1.222.54
# LB5 = 13.250.43.17


# 13.251.49.54 - CMS Production
# 54.169.165.81 - Testing 1
# 13.250.127.183 - testing 2


server '13.250.127.183',
user: 'ubuntu',
roles: %w{app web app},
ssh_options: {
  forward_agent: true,
}

set :stage, :production
set :branch, :master
set :ssh_options, {:forward_agent => true}

# Setting RAILS_ENV environment variable on server
set :rails_env, :production
