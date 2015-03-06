name 'zabbix_server'
description 'install zabbix server'
default_attributes 'zabbix' => {
  'server'    => {
    'install_method'      => 'package',
    'version'             => '2.2.2',
  },
  'agent'     => {
    'servers'             => ['127.0.0.1'],
  },
  'database'  => {
    'install_method'      => 'mysql',
    'dbname'              => 'zabbix',
    'dbuser'              => 'zabbix',
    'dbhost'              => 'localhost',
    'dbpassword'          => 'ilikerandompasswords',
  },
  'web'       => {
    'login'               => 'admin',
    'password'            => 'ilikerandompasswords',
    'lang'                => 'ja_JP',
  },
  'sender'    => {
    'version'             => '2.2.2',
  },
  'src_dir'   => '/usr/share/doc/'
},
'mysql' => {
  'server_root_password'  => 'ilikerandompasswords'
}

run_list(
  "recipe[hyclops::depend_packages]",
  "recipe[mysql::server]",
  "recipe[database::mysql]",
  #"recipe[mysql::client]",
  'role[zabbix_agent]',
  'recipe[zabbix::server]',
  'recipe[zabbix::get]',
  'recipe[zabbix::init_sql_cfg]',
  "recipe[zabbix::database]"
)
