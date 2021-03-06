#
# Cookbook Name:: hyclops
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "zabbix::sender"
include_recipe "hyclops::install_package"
include_recipe "hyclops::install_python_package"
include_recipe "hyclops::install_hyclops_module"
include_recipe "hyclops::copy_init_file"
include_recipe "hyclops::startup_hyclops"
include_recipe "hyclops::import_data"
include_recipe "hyclops::set_cron"
include_recipe "hyclops::replace_frontend"
include_recipe "hyclops::script_copy"
