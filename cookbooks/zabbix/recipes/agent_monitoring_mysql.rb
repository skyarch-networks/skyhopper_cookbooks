template "my.cnf" do
  path node['zabbix']['agent']['mycnf_path'] 
  source "my.cnf.erb"
  unless node['platform_family'] == "windows"
    owner "root"
    group "zabbix"
    mode  "640"
  end
  notifies :restart, "service[#{node['zabbix']['agent']['service_name']}]"
end

template "userparameter_mysql.conf.erb" do
  path "/etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf"
  source "userparameter_mysql.conf.erb"
  notifies :restart, "service[#{node['zabbix']['agent']['service_name']}]"
end

directory "/etc/mysql/conf.d" do
  only_if { File.directory?("/etc/mysql/conf.d") }
  mode "777"
end

