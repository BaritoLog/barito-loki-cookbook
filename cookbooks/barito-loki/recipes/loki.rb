#
# Cookbook:: barito-loki
# Recipe:: loki
#
# Copyright:: 2019, The Authors, All Rights Reserved.

barito_loki_service_account node[cookbook_name]['user'] do
  group node[cookbook_name]['group']
end

include_recipe "#{cookbook_name}::loki_server"
include_recipe "#{cookbook_name}::promtail"
