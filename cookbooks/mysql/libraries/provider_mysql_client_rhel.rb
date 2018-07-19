require 'chef/provider/lwrp_base'

class Chef
  class Provider
    class MysqlClient
      class Rhel < Chef::Provider::MysqlClient
        use_inline_resources if defined?(use_inline_resources)

        def whyrun_supported?
          true
        end

        action :create do
          converge_by 'rhel pattern' do
            %w(mysql mysql-devel).each do |p|
              package p do
                action :install
              end
            end
          end
        end

        action :delete do
          converge_by 'rhel pattern' do
            %w(mysql mysql-devel).each do |p|
              package p do
                action :remove
              end
            end
          end
        end
      end
    end
  end
end

Chef::Provider::MysqlClient::Rhel.provides :mysql_client, platform: "rhel"
Chef::Provider::MysqlClient::Rhel.provides :mysql_client, platform: "amazon"
Chef::Provider::MysqlClient::Rhel.provides :mysql_client, platform: "redhat"
Chef::Provider::MysqlClient::Rhel.provides :mysql_client, platform: "centos"
Chef::Provider::MysqlClient::Rhel.provides :mysql_client, platform: "oracle"
Chef::Provider::MysqlClient::Rhel.provides :mysql_client, platform: "scientific"
