include_recipe 'zabbix::package_repo'

package 'zabbix-sender' do
  action :install
  version "#{node['zabbix']['sender']['version']}-1.el6"
end
