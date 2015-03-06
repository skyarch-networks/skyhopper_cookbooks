package 'git' do
  action :install
end.run_action(:install)

git node['serverspec-handler']['git-dir'] do
  repository 'https://github.com/pocke/chef-serverspec-handler.git'
  revision "add_safe_option"
  action :sync
end.run_action(:sync)

execute 'make gem' do
  cwd node['serverspec-handler']['git-dir']
  command 'gem build chef-serverspec-handler.gemspec'
end.run_action(:run)

chef_gem 'chef-serverspec-handler' do
  action :install
  source File::join(node['serverspec-handler']['git-dir'], 'chef-serverspec-handler-0.0.0.gem')
end
