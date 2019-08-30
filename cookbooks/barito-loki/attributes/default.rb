#
# Cookbook:: barito-loki
# Attribute:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#
#

cookbook_name = 'barito-loki'

# User and group of service process
default[cookbook_name]['user'] = 'barito_loki'
default[cookbook_name]['group'] = 'barito_loki'

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
default[cookbook_name]['flow']['version'] = 'v1.0.0'
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
default[cookbook_name]['flow']['env_vars'] = {
  'BARITO_LOKI_URL' => 'http://192.168.28.68:3100'
}

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

#
# Loki
#

# default version
default[cookbook_name]['loki']['version'] = 'v0.2.0'
loki_version = node[cookbook_name]['loki']['version']

# where to get the compressed (.gz) binary
default[cookbook_name]['loki']['gz'] = 'loki_linux_amd64.gz'
loki_gz = node[cookbook_name]['loki']['gz']
default[cookbook_name]['loki']['mirror_gz'] =
  "https://github.com/grafana/loki/releases/download/#{loki_version}/#{loki_gz}"
default[cookbook_name]['loki']['service_name'] = 'loki'

# config yml
default[cookbook_name]['loki']['prefix_config'] = '/etc/default'
default[cookbook_name]['loki']['config_file'] =
  "#{node[cookbook_name]['loki']['prefix_config']}/#{node[cookbook_name]['loki']['service_name']}-config.yml"
default[cookbook_name]['loki']['config'] = {
  'auth_enabled' => false,
  'server' => {
    'http_listen_port' => 3100
  },
  'ingester' => {
    'lifecycler' => {
      'address' => '127.0.0.1',
      'ring' => {
        'kvstore' => {
          'store' => 'inmemory'
        },
        'replication_factor' => 1
      },
      'final_sleep' => '0s'
    },
    'chunk_idle_period' => '5m',
    'chunk_retain_period' => '30s'
  },
  'schema_config' => {
    'configs' => [
      {
        'from' => '2018-04-15',
        'store' => 'boltdb',
        'object_store' => 'filesystem',
        'schema' => 'v9',
        'index' => {
          'prefix' => 'index_',
          'period' => '168h'
        }
      }
    ]
  },
  'storage_config' => {
    'boltdb' => {
      'directory' => '/tmp/loki/index'
    },
    'filesystem' => {
      'directory' => '/tmp/loki/chunks'
    }
  },
  'limits_config' => {
    'enforce_metric_name' => false,
    'reject_old_samples' => true,
    'reject_old_samples_max_age' => '168h'
  },
  'chunk_store_config' => {
    'max_look_back_period' => 0
  },
  'table_manager' => {
    'chunk_tables_provisioning' => {
      'inactive_read_throughput' => 0,
      'inactive_write_throughput' => 0,
      'provisioned_read_throughput' => 0,
      'provisioned_write_throughput' => 0
    },
    'index_tables_provisioning' => {
      'inactive_read_throughput' => 0,
      'inactive_write_throughput' => 0,
      'provisioned_read_throughput' => 0,
      'provisioned_write_throughput' => 0
    },
    'retention_deletes_enabled' => false,
    'retention_period' => 0
  }
}

# loki daemon options, used to create the ExecStart option in service
default[cookbook_name]['loki']['cli_opts'] = ["-config.file=#{node[cookbook_name]['loki']['config_file']}"]

# log file location
default[cookbook_name]['loki']['prefix_log'] = '/var/log/loki'
default[cookbook_name]['loki']['log_file_name'] = 'error.log'

# default Systemd service unit, include config
default[cookbook_name]['loki']['systemd_unit'] = {
  'Unit' => {
    'Description' => 'loki server',
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
# Promtail
#

# default version
default[cookbook_name]['promtail']['version'] = 'v0.2.0'
promtail_version = node[cookbook_name]['promtail']['version']

# where to get the compressed (.gz) binary
default[cookbook_name]['promtail']['gz'] = 'promtail_linux_amd64.gz'
promtail_gz = node[cookbook_name]['promtail']['gz']
default[cookbook_name]['promtail']['mirror_gz'] =
  "https://github.com/grafana/loki/releases/download/#{promtail_version}/#{promtail_gz}"
default[cookbook_name]['promtail']['service_name'] = 'promtail'

# config yml
default[cookbook_name]['promtail']['prefix_config'] = '/etc/default'
default[cookbook_name]['promtail']['config_file'] =
  "#{node[cookbook_name]['promtail']['prefix_config']}/#{node[cookbook_name]['promtail']['service_name']}-config.yml"
default[cookbook_name]['promtail']['config'] = {
  'server' => {
    'http_listen_port' => 9080,
    'grpc_listen_port' => 0
  },
  'positions' => {
    'filename' => '/tmp/positions.yaml'
  },
  'clients' => [
    {
      'url' => 'http://localhost:3100/api/prom/push'
    }
  ],
  'scrape_configs' => [
    {
      'job_name' => 'system',
      'static_configs' => [
        {
          'targets' => [
            'localhost'
          ],
          'labels' => {
            'job' => 'varlogs',
            '__path__' => '/var/log/*log'
          }
        }
      ]
    }
  ]
}

# promtail daemon options, used to create the ExecStart option in service
default[cookbook_name]['promtail']['cli_opts'] = ["-config.file=#{node[cookbook_name]['promtail']['config_file']}"]

# log file location
default[cookbook_name]['promtail']['prefix_log'] = '/var/log/promtail'
default[cookbook_name]['promtail']['log_file_name'] = 'error.log'

# default Systemd service unit, include config
default[cookbook_name]['promtail']['systemd_unit'] = {
  'Unit' => {
    'Description' => 'promtail server',
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
# Grafana
#

default[cookbook_name]['grafana']['service_name'] = 'grafana-server'

# environment variables
default[cookbook_name]['grafana']['prefix_env_vars'] = '/etc/default'
default[cookbook_name]['grafana']['env_vars_file'] =
  "#{node[cookbook_name]['grafana']['prefix_env_vars']}/#{node[cookbook_name]['grafana']['service_name']}"
default[cookbook_name]['grafana']['env_vars'] = {
  'GRAFANA_USER' => 'grafana',
  'GRAFANA_GROUP' => 'grafana',
  'GRAFANA_HOME' => '/usr/share/grafana',
  'LOG_DIR' => '/var/log/grafana',
  'DATA_DIR' => '/var/lib/grafana',
  'MAX_OPEN_FILES' => 10_000,
  'CONF_DIR' => '/etc/grafana',
  'CONF_FILE' => '/etc/grafana/grafana.ini',
  'RESTART_ON_UPGRADE' => true,
  'PLUGINS_DIR' => '/var/lib/grafana/plugins',
  'PROVISIONING_CFG_DIR' => '/etc/grafana/provisioning',
  'PID_FILE_DIR' => '/var/run/grafana'
}

# for adding datasources
default[cookbook_name]['grafana']['prefix_datasource'] = '/etc/grafana/provisioning/datasources'
default[cookbook_name]['grafana']['datasource_file'] =
  "#{node[cookbook_name]['grafana']['prefix_datasource']}/datasource.yml"
default[cookbook_name]['grafana']['datasource'] = {
  'apiVersion' => 1,
  'datasources' => [
    {
      'name' => 'Loki',
      'type' => 'loki',
      'access' => 'proxy',
      'url' => 'http://192.168.28.68:3100',
      'jsonData' => {
        'maxLines' => 1000
      }
    }
  ]
}
