#
# Cookbook Name:: td-agent
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "td.repo" do
  path "/etc/yum.repos.d/td.repo"
  action :create_if_missing
end

yum_package "td-agent" do
  action :install
end

service "td-agent" do
  action :start
end
