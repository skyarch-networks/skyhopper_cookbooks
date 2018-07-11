#
# Cookbook Name:: tz-japan
# Recipe:: default
#
# Copyright 2013, Skyarch networks inc.
#
# All rights reserved - Do Not Redistribute
#
#
timezone = "Japan"
service "sysklogd"

link "/etc/localtime" do
  to "/usr/share/zoneinfo/#{timezone}"
  not_if "readlink /etc/localtime | grep -q '#{timezone}$'"
end

