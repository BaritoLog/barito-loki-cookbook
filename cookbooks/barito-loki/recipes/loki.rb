#
# Cookbook:: barito-loki
# Recipe:: loki
#
# Copyright:: 2019, The Authors, All Rights Reserved.

service_name = node[cookbook_name]['loki']['service_name']

barito_loki_service_account node[cookbook_name]['user'] do
  group node[cookbook_name]['group']
end

barito_loki_binary_install service_name do
  version node[cookbook_name]['loki']['version']
  prefix_root node[cookbook_name]['prefix_root']
  prefix_bin node[cookbook_name]['prefix_bin']
  prefix_temp node[cookbook_name]['prefix_temp']
  mirror node[cookbook_name]['loki']['mirror']
  user node[cookbook_name]['user']
  group node[cookbook_name]['group']
end

config_file = node[cookbook_name]['loki']['config_file']
barito_loki_config_yml_file config_file do
  config node[cookbook_name]['loki']['config']
  user node[cookbook_name]['user']
  group node[cookbook_name]['group']
end

bin = "#{node[cookbook_name]['prefix_bin']}/#{service_name}"
barito_loki_binary_systemd service_name do
  cli_opts node[cookbook_name]['loki']['cli_opts']
  systemd_unit node[cookbook_name]['loki']['systemd_unit']
  bin bin
  env_vars_file config_file
  prefix_log node[cookbook_name]['loki']['prefix_log']
  log_file_name node[cookbook_name]['loki']['log_file_name']
end
