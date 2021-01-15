# frozen_string_literal: true

remote_file '/tmp/node_exporter.tar.gz' do
  source "https://github.com/prometheus/node_exporter/releases/download/v#{node['node_exporter']['version']}/node_exporter-#{node['node_exporter']['version']}.linux-amd64.tar.gz"
  owner 'root'
  group 'root'
  mode '0755'
  backup false
  action :create_if_missing
  notifies :run, 'execute[extract_node_exporter]', :immediately
end

execute 'extract_node_exporter' do
  command <<-BASH
    tar xf /tmp/node_exporter.tar.gz
    mv node_exporter-#{node['node_exporter']['version']}.linux-amd64/node_exporter /usr/local/bin/node_exporter
    chmod +x /usr/local/bin/node_exporter
  BASH
  action :nothing
end

poise_service 'node_exporter' do
  user 'root'
  command <<-BASH
    /usr/local/bin/node_exporter
  BASH
  action %i[enable restart]
end
