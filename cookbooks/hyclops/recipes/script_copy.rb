execute "copy externalscripts" do
  command "cp #{node['hyclops']['download_path']}/misc/externalscripts/* #{node['zabbix']['external_dir']}"
  action :run
end

execute "chown externalscripts" do
  command "chown -R #{node['zabbix']['login']}:#{node['zabbix']['group']} #{node['zabbix']['external_dir']}/*"
  action :run
end
execute "chmod externalscripts" do
  command "chmod -R 744 #{node['zabbix']['external_dir']}/*"
  action :run
end
