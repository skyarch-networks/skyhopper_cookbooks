package 'mysql-devel' do
  action :install
end

execute 'dev-tools' do
  command 'yum -y groupinstall "Development Tools" "Development Libraries"'
end
