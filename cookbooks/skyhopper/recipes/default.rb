if node[:platform] != 'amazon'
  raise "#{node[:platform]} not supported."
end

attr = node['skyhopper']

package 'ruby20' do
  action :remove
end

package 'ruby22' do
  action :install
end

gem_package 'bundler' do
  action :install
end

%w[nodejs npm].each do |p|
  yum_package p do
    action :install
    options '--enablerepo=epel'
  end
end

execute 'npm install -g bower' do
  command "sudo npm install bower --global"
  not_if {system('which bower > /dev/null 2>&1')}
end

execute 'yum groupinstall devtool, devlibs' do
  command "sudo yum -y groupinstall 'Development tools' 'Development Libraries'"
end

%w[ruby22-devel sqlite-devel zlib-devel readline-devel openssl-devel libxml2-devel libxslt-devel mysql-devel mysql].each do |p|
  package p do
    action :install
  end
end

service 'redis' do
  supports status: true, restart: true, reload: true
  action :nothing
end

service 'mysqld' do
  supports status: true, restart: true, reload: true
  action :nothing
end

service 'nginx' do
  supports status: true, restart: true, reload: true
  action :nothing
end

yum_package 'redis' do
  action :install
  options '--enablerepo=epel'
  notifies :start, 'service[redis]'
  notifies :enable, 'service[redis]'
end

package 'mysql-server' do
  action :install
  notifies :start, 'service[mysqld]', :immediately
  notifies :enable, 'service[mysqld]'
end

package 'nginx' do
  action :install
  notifies :enable, 'service[nginx]'
end

template 'nginx skyhopper.conf' do
  source 'nginx_skyhopper.conf.erb'
  path "/etc/nginx/conf.d/skyhopper.conf"

  notifies :restart, 'service[nginx]'
end

git attr['root_dir'] do
  repository attr['repo_url']
  action :sync
  user 'ec2-user'
  group 'ec2-user'
end
