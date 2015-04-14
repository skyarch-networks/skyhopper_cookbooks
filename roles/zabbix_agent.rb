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
    'include_dir' => '/etc/zabbix/zabbix_agentd.d'
  }
}

run_list(
  "recipe[zabbix]"
)
