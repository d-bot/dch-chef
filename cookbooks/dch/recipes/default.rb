#
# Cookbook Name:: dch
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w/ vim /.each do |pkg|
  package pkg do
    action :install
  end
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
