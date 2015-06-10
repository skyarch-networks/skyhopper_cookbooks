#
# Cookbook Name:: ElasticSearch
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package_path = "/usr/local/src/elasticsearch-#{node["elasticsearch"]["version"]}.noarch.rpm"
source_url = "https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-#{node["elasticsearch"]["version"]}.noarch.rpm"

remote_file package_path do
  source source_url
  not_if {File.exists?(package_path)}
end

rpm_package "elasticsearch" do
  source package_path
  action :install
end

script "add ElasticSearch to service" do
  interpreter "bash"
  code <<-EOC
    chkconfig --add elasticsearch
  EOC
end

script "set not_analyzed to string" do
  interpreter "bash"
  code <<-EOC
  service elasticsearch start
  sleep 20
  curl -XPUT 'http://localhost:9200/_template/string_template' -d '{
      "template": "*",
      "mappings": {
          "_default_": {
              "_source": { "compress": true },
              "dynamic_templates": [
                  {
                      "string_template" : {
                          "match" : "*",
                          "mapping": {
                              "type": "multi_field",
                              "fields": {
                                  "{name}": {
                                      "type": "string",
                                      "index" : "analyzed"
                                  },
                                  "full": {
                                      "type": "string",
                                      "index" : "not_analyzed"
                                  }
                              }
                          },
                          "match_mapping_type" : "string"
                      }
                  }
              ]
          }
      }
  }'
  EOC
end
