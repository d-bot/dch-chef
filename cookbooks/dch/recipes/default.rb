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

%w/ hosts.allow hosts.deny /.each do |h_conf|
  file "/etc/#{h_conf}" do
    owner "root"
    group "root"
    mode "0644"
    content ::File.open("/home/dchoi/chef-repo/cookbooks/dch/files/default/#{h_conf}").read
    action :create
  end
end

%w/ rrdtool vim /.each do |pkg|
  package pkg do
    action :install
  end
end

gem_package "unicorn" do
  action :upgrade
end

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
git "/home/dchoi/octopress/source/_posts" do
  repository "https://github.com/d-bot/octopress.git"
  reference "master"
  action :sync
  user "dchoi"
  group "dchoi"
end

