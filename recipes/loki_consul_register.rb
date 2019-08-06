#
# Cookbook:: barito-loki
# Recipe:: loki_consul_register
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#
#

config = {
  "id": "#{node['hostname']}-#{node[cookbook_name]['loki']['service_name']}",
  "name": (node[cookbook_name]['loki']['service_name']).to_s,
  "tags": ['app:'],
  "address": node['ipaddress'],
  "port": 3100,
  "meta": {
    "http_schema": 'http'
  }
}

consul_register_service (node[cookbook_name]['promtail']['service_name']).to_s do
  config config
  config_dir  node[cookbook_name]['consul']['config_dir']
  consul_bin  node[cookbook_name]['consul']['bin']
end

config = {
  "id": "#{node['hostname']}-#{node[cookbook_name]['promtail']['service_name']}",
  "name": (node[cookbook_name]['promtail']['service_name']).to_s,
  "tags": ['app:'],
  "address": node['ipaddress'],
  "port": 9080,
  "meta": {
    "http_schema": 'http'
  }
}

consul_register_service (node[cookbook_name]['promtail']['service_name']).to_s do
  config config
  config_dir  node[cookbook_name]['consul']['config_dir']
  consul_bin  node[cookbook_name]['consul']['bin']
end
