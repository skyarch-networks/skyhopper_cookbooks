name 'zabbix_agent'
description 'install zabbix agent'
default_attributes 'zabbix' => {
  'agent' => {
    # Zabbix サーバーに EIP を付与し、
    # その EIP の Public DNS を指定すること。
    'servers' => ['to.be.set.public.dns.with.eip'],
    'servers_active' => ['to.be.set.public.dns.with.eip'],
    'install_method' => 'package',
    'version' => '2.2.9',
    'service_name' => 'zabbix-agent', 
    'include_dir' => '/etc/zabbix/zabbix_agentd.d',
    'log_file' => '/var/log/zabbix/zabbix_agentd.log' # Zabbix3.0では必須
  },
  'package' => {
    'rpm' => 'http://repo.zabbix.com/zabbix/2.2/rhel/6/x86_64/zabbix-release-2.2-1.el6.noarch.rpm'
  }
}

run_list(
  "recipe[zabbix]"
)
