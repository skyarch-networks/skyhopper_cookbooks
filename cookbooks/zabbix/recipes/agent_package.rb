raise "Do not support #{node[:platform]}" unless %w[amazon redhat].include? node[:platform]

include_recipe "zabbix::agent_common"
include_recipe 'zabbix::package_repo'

package node['zabbix']['agent']['package'] do
  action :install
  version "#{node['zabbix']['agent']['version']}-1.el6"
  notifies :restart, "service[#{node['zabbix']['agent']['service_name']}]"
end
