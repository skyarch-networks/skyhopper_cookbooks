# Manage Agent service
case node['zabbix']['agent']['init_style']
when "sysvinit"
  unless node['zabbix']['agent']['install_method'] == 'package'
    template "/etc/init.d/zabbix_agentd" do
      source value_for_platform_family([ "rhel" ] => "zabbix_agentd.init-rh.erb", "default" => "zabbix_agentd.init.erb")
      owner "root"
      group "root"
      mode "754"
    end
  end

  # Define zabbix_agentd service
  service node['zabbix']['agent']['service_name'] do
    supports :status => true, :start => true, :stop => true, :restart => true
    action :nothing
  end
when "windows"
  service node['zabbix']['agent']['service_name'] do
    service_name "Zabbix Agent"
    provider Chef::Provider::Service::Windows
    supports :restart => true
    action :nothing
  end
end
