root_dirs = [
  node['zabbix']['agent']['include_dir']
]

# Create root folders
root_dirs.each do |dir|
  directory dir do
    unless node['platform'] == "windows"
      owner "root"
      group "root"
      mode "755" 
    end
    recursive true
    #notifies :restart, "service[#{node['zabbix']['agent']['service_name']}]"
    Chef::Log.logger.info dir
    subscribes :restart, dir
  end
end
