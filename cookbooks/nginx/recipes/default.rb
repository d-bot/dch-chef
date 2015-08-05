#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "nginx" do
  action :install
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

template "nginx.conf" do
  path "/etc/nginx/nginx.conf"
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :reload, 'service[nginx]'
end

%w/ octopress.conf dch.conf delp.conf /.each do |v_conf|
  file "/etc/nginx/conf.d/#{v_conf}" do
    owner "root"
    group "root"
    mode "0644"
    content ::File.open("/home/dchoi/chef-repo/cookbooks/nginx/files/default/#{v_conf}").read
    action :create
    notifies :reload, 'service[nginx]'
  end
end
