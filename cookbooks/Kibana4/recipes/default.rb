#
# Cookbook Name:: Kibana4
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package_path = "/usr/local/src/kibana-#{node["kibana"]["version"]}-linux-x64.tar.gz"
source_url = "https://download.elastic.co/kibana/kibana/kibana-#{node["kibana"]["version"]}-linux-x64.tar.gz"

remote_file package_path do
  source source_url
  not_if {File.exists?(package_path)}
end

script "Kibana install script" do
  interpreter "bash"
  cwd "/usr/local/src"
  code <<-EOC
    tar xvzf kibana-#{node["kibana"]["version"]}-linux-x64.tar.gz
    chown -R root:root kibana-#{node["kibana"]["version"]}-linux-x64
    mv kibana-#{node["kibana"]["version"]}-linux-x64 kibana
    mv kibana /usr/local
  EOC
  not_if {File.exists?("/usr/local/kibana")}
end

cookbook_file "kibana-init-script" do
  path "/etc/init.d/kibana"
  mode 0755
  action :create_if_missing
end

script "add Kibana to service" do
  interpreter "bash"
  code <<-EOC
    chkconfig --add kibana
  EOC
end

service "kibana" do
  action :start
end
