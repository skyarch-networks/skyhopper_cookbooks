include_recipe "hyclops::download_hyclops"

execute "install HyClops" do
  command "#{node['hyclops']['download_path']}/setup.py install"
  action :run
end

include_recipe "hyclops::make_config"

