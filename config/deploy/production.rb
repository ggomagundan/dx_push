# -*- encoding : utf-8 -*-
# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role

#role :app, %w{deploy@example.com}
#role :web, %w{deploy@example.com}
#role :db,  %w{deploy@example.com}

set :branch,  'master'
set :domain, "14.63.165.216"
set :rails_env, "production"
set :current_deploy_path, "/geuinea_pig/priday/current"
# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server '14.63.165.216', user: 'root', roles: %w{web app db}, primary: true#, my_property: :my_value



set :deploy_to, '/geuinea_pig/priday'
 set :ssh_options, {
     user: 'root', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
     forward_agent: false,
     #auth_methods: %w(publickey password),
     auth_methods: %w(password),
      password: 'dPffhdPffh1!'
   }

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# and/or per server
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
# set :ssh_options, {
#     user: '', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password),
#      password: ''
#   }
# setting per server overrides global ssh_options
