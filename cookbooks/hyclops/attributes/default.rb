default['hyclops']['version'] = '0.2.0'
default['hyclops']['source_url'] = "https://github.com/tech-sketch/hyclops/archive/#{default['hyclops']['version']}.tar.gz"
default['hyclops']['install_dir'] = '/opt/hyclops'
default['hyclops']['download_path'] = '/tmp/hyclops'

# settings
default['hyclops']['server'] = '127.0.0.1'
default['hyclops']['port'] = '5555'
default['hyclops']['log_level'] = 'WARNING'
default['hyclops']['log_file'] = '/opt/hyclops/logs/hyclops_server.log'

default['zabbix']['frontend_url'] = "http://#{default['zabbix']['server']['host']}/zabbix"

require 'open-uri'

gateone_public_ip = open('http://169.254.169.254/latest/meta-data/public-ipv4').read
default['gateone']['url'] = "https://#{gateone_public_ip}"

# Set ZeroMQ package repository URL for CentOS,RHEL,AmazonLinux
# version 5 url: http://download.opensuse.org/repositories/home:/fengshuo:/zeromq/CentOS_CentOS-5/home:fengshuo:zeromq.repo
# version 6 url: http://download.opensuse.org/repositories/home:/fengshuo:/zeromq/CentOS_CentOS-6/home:fengshuo:zeromq.repo 
default['zeromq']['repo_url'] = 'http://download.opensuse.org/repositories/home:/fengshuo:/zeromq/CentOS_CentOS-6/home:fengshuo:zeromq.repo'
