
# TODO: amazon linux 以外

attr = node['skyhopper']

package 'ruby20' do
  action :remove
end

package 'ruby21' do
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

%w[ruby21-devel sqlite-devel zlib-devel readline-devel openssl-devel libxml2-devel libxslt-devel mysql-devel mysql].each do |p|
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

# execute 'mysql create user' do
#   # XXX: 冪等じゃない. デバッグ時は drop user skyhopper_prod@localhost; すると通ります
#   command <<-EOC
# cat <<CMD | mysql -uroot
# SET storage_engine=INNODB;
# CREATE USER '#{attr['db']['user']}'@'localhost' IDENTIFIED BY '#{attr['db']['password']}';
# CREATE DATABASE IF NOT EXISTS \\`#{attr['db']['name']}\\` DEFAULT CHARACTER SET \\`utf8\\` COLLATE \\`utf8_unicode_ci\\`;
# GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, LOCK TABLES ON \\`#{attr['db']['name']}\\`.* TO '#{attr['db']['user']}'@'localhost';
# quit
# CMD
#   EOC
# end

git attr['root_dir'] do
  repository attr['repo_url']
  action :sync
end

# execute 'bundle install' do
#   command <<-EOC
# cd #{attr['root_dir']}
# bundle install --path vendor/bundle
#   EOC
# end

# execute 'bower install' do
#   command <<-EOC
# cd #{attr['root_dir']}
# bower install --allow-root
#   EOC
# end

# template 'database.yml' do
#   source 'database.yml.erb'
#   path File.join(attr['root_dir'], 'config', 'database.yml')
# end

# execute 'setup database' do
#   # XXX: 冪等じゃない(たぶん)
#   command <<-EOC
#   cd #{attr['root_dir']}
#   bundle exec rake db:create
#   bundle exec rake db:migrate
#   bundle exec rake db:seed
#   EOC
#   environment "RAILS_ENV" => 'production'
# end

template 'nginx skyhopper.conf' do
  source 'nginx_skyhopper.conf.erb'
  path "/etc/nginx/conf.d/skyhopper.conf"

  notifies :restart, 'service[nginx]'
end

# execute 'skyhopper' do
#   action :nothing
#   command <<-EOC
#   #{File.join(attr['root_dir'], 'scripts', 'skyhopper_daemon.sh')} start
#   EOC
#   notifies :run, 'execute[skyhopper]'
#   # XXX: 冪等じゃない(たぶん)
# end
