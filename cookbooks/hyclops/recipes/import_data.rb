template "#{node['hyclops']['download_path']}/misc/import_data/globalmacros.xml" do
  source "globalmacros.xml.erb"
end

if node['zabbix']['server']['version'] =~ /2.2/ then
  cookbook_file 'templates.xml' do
    action :create
    mode   '664'
    owner  'root'
    group  'root'
    path   "#{node['hyclops']['download_path']}/misc/import_data/templates.xml"
    source 'templates.xml'
  end
end

# zabbix-server, httpd が起動していないとインポートができない
%w[zabbix-server httpd].each do |s|
  service s do
    action :start
    supports status: true, restart: true
  end
end

execute "import Zabbix template xml & set global scripts & set global macros(for Gateone)" do
  command <<-CMD
    #{node['hyclops']['download_path']}/setup.py import \
    -f #{node.zabbix.frontend_url} \
    -u #{node['zabbix']['web']['login']} \
    -p #{node['zabbix']['web']['password']}
  CMD
  action :run
end
