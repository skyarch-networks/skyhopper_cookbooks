require 'digest/md5'

case node['zabbix']['database']['install_method']
when 'mysql', 'rds_mysql'
else
  raise "#{node['zabbix']['database']['install_method']} is not support database install_method"
end

unless node['zabbix']['server']['install_method'] == 'package' then
  raise "#{node['zabbix']['server']['install_method']} is not support server install_method"
end
unless 2.0 < node['zabbix']['server']['version'].to_f then
  raise "#{node['zabbix']['server']['version']} is not support server version"
end

script_path = File::join(
  node['zabbix']['src_dir'],
  "zabbix-server-mysql-#{node['zabbix']['server']['version']}",
  'create',
  'data.sql'
)

unless node['zabbix']['server']['version'] =~ /\A3\.0\./
  template script_path do
    owner 'root'
    group 'root'
    mode  '644'
    source 'data.sql.erb'
    pass = node['zabbix']['web']['password'] || 'zabbix'
    variables(
      web_passwd: Digest::MD5::hexdigest(pass),
      web_lang:   node['zabbix']['web']['lang'] || 'en_GB'
    )
  end
end