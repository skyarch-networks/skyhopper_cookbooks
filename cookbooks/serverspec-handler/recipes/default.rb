require 'fileutils'

if node['serverspec-handler']['safe']
  include_recipe 'serverspec-handler::_safe'
else
  include_recipe 'serverspec-handler::_origin'
end

require 'chef-serverspec-handler'

FileUtils::rm_rf(node['serverspec-handler']['output_dir'], secure: true)
directory(node['serverspec-handler']['output_dir']).run_action(:create)

Chef::Config[:report_handlers] << ChefServerspecHandler.new(
  output_dir: node['serverspec-handler']['output_dir'],
  safe:       node['serverspec-handler']['safe']
)
