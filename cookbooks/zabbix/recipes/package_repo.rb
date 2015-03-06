rpm_name = File::basename(node['zabbix']['package']['rpm'])
remote_file "#{Chef::Config[:file_cache_path]}/#{rpm_name}" do
  source node['zabbix']['package']['rpm']
  not_if {system("rpm -qa | grep -q '^zabbix-release'")}
  action :create
  notifies :install, 'rpm_package[zabbix-release]', :immediately
end

rpm_package 'zabbix-release' do
  source "#{Chef::Config[:file_cache_path]}/#{rpm_name}"
  action :nothing
end
