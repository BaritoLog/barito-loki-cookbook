#
# Cookbook:: barito-loki
# Recipe:: grafana
#
# Copyright:: 2019, The Authors, All Rights Reserved.

service_name = node[cookbook_name]['grafana']['service_name']

barito_loki_service_account node[cookbook_name]['user'] do
  group node[cookbook_name]['group']
end

apt_repository 'grafana' do
  uri           'https://packages.grafana.com/oss/deb'
  key           'https://packages.grafana.com/gpg.key'
  distribution  'stable'
  components    ['main']
  action        :add
end

apt_package 'grafana' do
  action :install
end

config_file = node[cookbook_name]['grafana']['datasource_file']
barito_loki_config_yml_file config_file do
  config node[cookbook_name]['grafana']['datasource']
  user node[cookbook_name]['user']
  group node[cookbook_name]['group']
end

env_vars_file = node[cookbook_name]['grafana']['env_vars_file']
barito_loki_env_vars_file env_vars_file do
  env_vars node[cookbook_name]['grafana']['env_vars']
  user node[cookbook_name]['user']
  group node[cookbook_name]['group']
end

systemd_unit "#{service_name}.service" do
  triggers_reload true
  action %i[enable start]
end
