#
# Cookbook:: barito-loki
# Recipe:: router
#
# Copyright:: 2019, The Authors, All Rights Reserved.

service_name = node[cookbook_name]['router']['service_name']

barito_loki_service_account node[cookbook_name]['user'] do
  group node[cookbook_name]['group']
end

barito_loki_binary_install service_name do
  version node[cookbook_name]['router']['version']
  prefix_root node[cookbook_name]['prefix_root']
  prefix_bin node[cookbook_name]['prefix_bin']
  prefix_temp node[cookbook_name]['prefix_temp']
  mirror node[cookbook_name]['router']['mirror']
  user node[cookbook_name]['user']
  group node[cookbook_name]['group']
end

env_vars_file = node[cookbook_name]['router']['env_vars_file']
barito_loki_env_vars_file env_vars_file do
  env_vars node[cookbook_name]['router']['env_vars']
  user node[cookbook_name]['user']
  group node[cookbook_name]['group']
end

bin = "#{node[cookbook_name]['prefix_bin']}/#{service_name}"
barito_loki_binary_systemd service_name do
  cli_opts node[cookbook_name]['router']['cli_opts']
  systemd_unit node[cookbook_name]['router']['systemd_unit']
  bin bin
  env_vars_file env_vars_file
  prefix_log node[cookbook_name]['router']['prefix_log']
  log_file_name node[cookbook_name]['router']['log_file_name']
end
