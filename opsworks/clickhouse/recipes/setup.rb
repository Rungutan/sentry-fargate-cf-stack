# frozen_string_literal: true

execute 'apt-get update'

(node['base_packages'] + node['custom_packages']).each do |pkg|
  package pkg
end

include_recipe 'clickhouse_stack::swap_sysctl'

include_recipe 'clickhouse_stack::logrotate'

include_recipe 'clickhouse_stack::clickhouse'

include_recipe 'clickhouse_stack::node_exporter'

include_recipe 'ntp::default'
