#
# Cookbook Name:: dch
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "/home/dchoi/chef-repo" do
  owner "dchoi"
  group "dchoi"
  mode "0755"
  action :create
end

file "/home/dchoi/.vimrc" do
  owner "dchoi"
  group "dchoi"
  mode "0644"
  content ::File.open("/home/dchoi/chef-repo/cookbooks/dch/files/default/vimrc").read
  action :create
end

file "/home/dchoi/.bashrc" do
  owner "dchoi"
  group "dchoi"
  mode "0644"
  content ::File.open("/home/dchoi/chef-repo/cookbooks/dch/files/default/bashrc").read
  action :create
end

file "/home/dchoi/.gitconfig" do
  owner "dchoi"
  group "dchoi"
  mode "0644"
  content ::File.open("/home/dchoi/chef-repo/cookbooks/dch/files/default/gitconfig").read
  action :create
end

file "/home/dchoi/.tmux.conf" do
  owner "dchoi"
  group "dchoi"
  mode "0644"
  content ::File.open("/home/dchoi/chef-repo/cookbooks/dch/files/default/tmux.conf").read
  action :create
end

file "/etc/hosts" do
  owner "dchoi"
  group "dchoi"
  mode "0644"
  content ::File.open("/home/dchoi/chef-repo/cookbooks/dch/files/default/hosts").read
  action :create
end

%w/ hosts.allow hosts.deny /.each do |h_conf|
  file "/etc/#{h_conf}" do
    owner "root"
    group "root"
    mode "0644"
    content ::File.open("/home/dchoi/chef-repo/cookbooks/dch/files/default/#{h_conf}").read
    action :create
  end
end

%w/ python3-pip ipython3 ipython3-notebook python-pip ipython ipython-notebook sendmail rrdtool vim tmux /.each do |pkg|
  package pkg do
    action :install
  end
end


%w/ unicorn mechanize dotenv nokogiri sinatra redcarpet rack rdiscount yelp /.each do |pkg|
  gem_package pkg do
    #source "github.com"
    action :install
  end
end

=begin
###
### dch.io home
###
git "/home/dchoi/projects/dch.io" do
  repository "https://github.com/d-bot/dch.git"
  reference "master"
  action :sync
  user "dchoi"
  group "dchoi"
end

###
### delp home
###
git "/home/dchoi/projects/delp" do
  repository "https://github.com/d-bot/delp.git"
  reference "master"
  action :sync
  user "dchoi"
  group "dchoi"
end

###
### octopress home
###
git "/home/dchoi/projects/octopress/source/_posts" do
  repository "https://github.com/d-bot/octopress.git"
  reference "master"
  action :sync
  user "dchoi"
  group "dchoi"
end


=end

link '/etc/pki/tls/certs/ca-bundle.crt' do
  to '/etc/ssl/certs/ca-certificates.crt'
  link_type :symbolic
end

cron 'rrd' do
  minute '*/5'
  user 'dchoi'
  mailto 'dchoi-bot@gmail.com'
  command 'ruby /home/dchoi/projects/dch.io/lib/rrd_scripts/update.rb && ruby /home/dchoi/projects/dch.io/lib/rrd_scripts/graph.rb'
end

cron 'fitbit' do
  minute '0'
  hour '10,14,19,21'
  user 'dchoi'
  path 'PATH=/usr/local/rvm/gems/ruby-2.1.1/bin:/usr/local/rvm/gems/ruby-2.1.1@global/bin:/usr/local/rvm/rubies/ruby-2.1.1/bin:/usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games'
  mailto 'dchoi-bot@gmail.com'
  command 'ruby /home/dchoi/hacks/fitbit.rb'
  #command %W{
  #  ruby /home/dchoi/hacks/fitbit.rb
  #}.join(' ')

  #command %W{
  #  cd /srv/supermarket/current &&
  #  env RUBYLIB="/srv/supermarket/current/lib"
  #  RAILS_ASSET_ID=`git rev-parse HEAD` RAILS_ENV="#{rails_env}"
  #  bundle exec rake cookbooks_report
  #}.join(' ')

end
