#
# Cookbook:: barito-loki
# Attribute:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#
#

cookbook_name = 'barito-loki'

# User and group of service process
default[cookbook_name]['user'] = 'barito'
default[cookbook_name]['group'] = 'barito'

# Temp directory
default[cookbook_name]['prefix_temp'] = '/var/cache/chef'
# Installation directory
default[cookbook_name]['prefix_root'] = '/opt'
# Where to link binaries
default[cookbook_name]['prefix_bin'] = '/opt/bin'

# Attributes for registering these services to consul
default[cookbook_name]['consul']['config_dir'] = '/opt/consul/etc'
default[cookbook_name]['consul']['bin'] = '/opt/bin/consul'

#
# Flow
#

# default version
default[cookbook_name]['flow']['version'] = 'v0.1'
flow_version = node[cookbook_name]['flow']['version']

# where to get the binary
default[cookbook_name]['flow']['binary'] = 'barito-loki-linux'
flow_binary = node[cookbook_name]['flow']['binary']
default[cookbook_name]['flow']['mirror'] =
  "https://github.com/vwidjaya/barito-loki/releases/download/#{flow_version}/#{flow_binary}"
default[cookbook_name]['flow']['service_name'] = 'barito-loki'

# environment variables
default[cookbook_name]['flow']['prefix_env_vars'] = '/etc/default'
default[cookbook_name]['flow']['env_vars_file'] =
  "#{node[cookbook_name]['flow']['prefix_env_vars']}/#{node[cookbook_name]['flow']['service_name']}"
default[cookbook_name]['flow']['env_vars'] = {}

# log file location
default[cookbook_name]['flow']['prefix_log'] = '/var/log/barito-loki'
default[cookbook_name]['flow']['log_file_name'] = 'error.log'

# default Systemd service unit, include config
default[cookbook_name]['flow']['systemd_unit'] = {
  'Unit' => {
    'Description' => 'barito loki',
    'After' => 'network.target'
  },
  'Service' => {
    'Type' => 'simple',
    'User' => node[cookbook_name]['user'],
    'Group' => node[cookbook_name]['group'],
    'Restart' => 'on-failure',
    'RestartSec' => 2,
    'StartLimitInterval' => 50,
    'StartLimitBurst' => 10,
    'ExecStart' => 'TO_BE_COMPLETED'
  },
  'Install' => {
    'WantedBy' => 'multi-user.target'
  }
}
