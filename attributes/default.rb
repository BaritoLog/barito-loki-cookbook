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

#
# default
#

# default version
default[cookbook_name]['default']['version'] = 'v0.1'
default_version = node[cookbook_name]['default']['version']

# where to get the binary
default[cookbook_name]['default']['binary'] = 'barito-loki-linux'
default_binary = node[cookbook_name]['default']['binary']
default[cookbook_name]['default']['mirror'] =
  "https://github.com/vwidjaya/barito-loki/releases/download/#{default_version}/#{default_binary}"
default[cookbook_name]['default']['service_name'] = 'barito-loki-default'

# environment variables
default[cookbook_name]['default']['prefix_env_vars'] = '/etc/default'
default[cookbook_name]['default']['env_vars_file'] =
  "#{node[cookbook_name]['default']['prefix_env_vars']}/#{node[cookbook_name]['default']['service_name']}"
default[cookbook_name]['default']['env_vars'] = {}

# log file location
default[cookbook_name]['default']['prefix_log'] = '/var/log/barito-loki-default'
default[cookbook_name]['default']['log_file_name'] = 'error.log'

# default Systemd service unit, include config
default[cookbook_name]['default']['systemd_unit'] = {
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

#
# Router
#

# router version
default[cookbook_name]['router']['version'] = 'v0.3.1'
router_version = node[cookbook_name]['router']['version']

# where to get the binary
default[cookbook_name]['router']['binary'] = 'barito-router-linux'
router_binary = node[cookbook_name]['router']['binary']
default[cookbook_name]['router']['mirror'] =
  "https://github.com/BaritoLog/barito-router/releases/download/#{router_version}/#{router_binary}"
default[cookbook_name]['router']['service_name'] = 'barito-router'

# environment variables
default[cookbook_name]['router']['prefix_env_vars'] = '/etc/default'
default[cookbook_name]['router']['env_vars_file'] =
  "#{node[cookbook_name]['router']['prefix_env_vars']}/#{node[cookbook_name]['router']['service_name']}"
default[cookbook_name]['router']['env_vars'] = {}

# router daemon options, used to create the ExecStart option in service
default[cookbook_name]['router']['cli_opts'] = ['a']

# log file location
default[cookbook_name]['router']['prefix_log'] = '/var/log/barito-router'
default[cookbook_name]['router']['log_file_name'] = 'error.log'

# router Systemd service unit, include config
default[cookbook_name]['router']['systemd_unit'] = {
  'Unit' => {
    'Description' => 'barito router',
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
