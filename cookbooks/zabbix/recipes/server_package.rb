raise "Do not support #{node[:platform]}" unless node[:platform] == 'amazon'
raise 'Do not support AMI version' if node[:platform_version].to_f < 2013.09

include_recipe 'zabbix::common'
include_recipe 'zabbix::server_common'

include_recipe 'zabbix::package_repo'

packages = case node['zabbix']['database']['install_method']
  when 'mysql', 'rds_mysql' then
    %w[zabbix-server-mysql zabbix-web-mysql]
  when 'postgres' then
    %w[zabbix-server-pgsql zabbix-web-pgsql]
  end

packages.each do |pkg|
  package pkg do
    action :install
    version "#{node['zabbix']['server']['version']}-1.el6"
  end
end

# install php54 and modules
if node['zabbix']['server']['version'] =~ /\A3\.0\./
  %w{ php54 php54-mysql php54-gd php54-bcmath php54-mbstring php54-xml }.each do |pack|
    package pack do
      action :install
    end
  end
end

# install zabbix server conf
template "#{node['zabbix']['etc_dir']}/zabbix_server.conf" do
  source "zabbix_server.conf.erb"
  owner "root"
  group "root"
  mode "644"
  variables(
    :dbhost             => node['zabbix']['database']['dbhost'],
    :dbname             => node['zabbix']['database']['dbname'],
    :dbuser             => node['zabbix']['database']['dbuser'],
    :dbpassword         => node['zabbix']['database']['dbpassword'],
    :dbport             => node['zabbix']['database']['dbport'],
    :java_gateway       => node['zabbix']['server']['java_gateway'],
    :java_gateway_port  => node['zabbix']['server']['java_gateway_port'],
    :java_pollers       => node['zabbix']['server']['java_pollers']
  )
  notifies :restart, "service[zabbix-server]", :delayed
end

if node['zabbix']['server']['version'] =~ /\A3\.0\./
  directory "#{node['zabbix']['etc_dir']}/web" do
    owner  'root'
    group  'root'
    mode   '755'
    action :create
  end
end

# install zabbix.conf.php
template "#{node['zabbix']['etc_dir']}/web/zabbix.conf.php" do
  source 'zabbix.conf.php.erb'
  owner  'apache'
  group  'apache'
  mode   '644'
end

cookbook_file 'zabbix.conf' do
  source 'zabbix.conf'
  path '/etc/httpd/conf.d/zabbix.conf'
  mode 0644
  owner 'root'
  group 'root'
  notifies :restart, "service[zabbix-server]", :delayed
  notifies :restart, "service[httpd]", :delayed
end

# Define zabbix_agentd service
service "zabbix-server" do
  supports :status => true, :start => true, :stop => true, :restart => true
  action [ :start, :enable ]
end

service 'httpd' do
  supports :status => true, :start => true, :stop => true, :restart => true
  action :enable
end
