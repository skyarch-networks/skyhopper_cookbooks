remote_file "/tmp/hyclops.tar.gz" do
  source node.hyclops.source_url
  action :create
end

execute "extract and rename for hyclops package" do
  command <<-"CMD"
    tar xvzf /tmp/hyclops.tar.gz -C /tmp
    mv /tmp/hyclops-#{node.hyclops.version} #{node['hyclops']['download_path']}
  CMD
  action :run
  not_if{ ::Dir::exists?(node['hyclops']['download_path']) }
end
