execute "replace frontend" do
  if /^(2.0|2.2)/ =~ node['zabbix']['server']['version']
    command <<-CMD
      #{node['hyclops']['download_path']}/setup.py replace \
      -d #{node['zabbix']['frontend_dir']} \
      --zabbix-version=#{$&}
    CMD
    action :run
  else
    p "Not supported version.(Supported only 2.0 or 2.2)"
  end
end
