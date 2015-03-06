case node.platform
when "centos","redhat","amazon"
  execute "copy init file" do
    command "cp #{node['hyclops']['download_path']}/misc/init.d/redhat/hyclops /etc/init.d/"
    action :run
    not_if{ ::File::exist?('/etc/init.d/hyclops') }
  end
when "ubuntu","debian"
  execute "copy init file" do
    command "cp #{node['hyclops']['download_path']}/misc/init.d/ubuntu/hyclops.conf /etc/init/"
    action :run
    not_if{ ::File::exist?('/etc/init/hyclops.conf') }
  end
end
