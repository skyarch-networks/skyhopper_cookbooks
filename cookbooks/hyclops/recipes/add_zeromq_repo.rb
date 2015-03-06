remote_file '/etc/yum.repos.d/zeromq.repo' do
  action :create
  mode 0644
  owner 'root'
  group 'root'
  source node.zeromq.repo_url
end
