# frozen_string_literal: true

default['clickhouse']['version']      = '20.10.3.30'
default['clickhouse']['conf_path']    = '/etc/clickhouse-server'
default['clickhouse']['log_path']     = '/var/log/clickhouse'
default['clickhouse']['lib_path']     = '/var/lib/clickhouse'
default['clickhouse']['run_path']     = '/run/clickhouse'
default['clickhouse']['region']       = ''
default['clickhouse']['server_name']  = ''
default['clickhouse']['user']         = 'clickhouse'
default['clickhouse']['group']        = 'clickhouse'
default['clickhouse']['display_name'] = 'sentry_clickhouse'
