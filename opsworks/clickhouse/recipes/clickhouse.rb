# frozen_string_literal: true

execute 'systemctl daemon-reload'

execute '(service clickhouse-server stop) || true'

bash 'create-clickhouse-user' do
  user 'root'
  code <<-BASH
    (groupadd #{node['clickhouse']['group']}) || true
    (useradd -c "ClickHouse - User" -d #{node['clickhouse']['conf_path']}/ -g #{node['clickhouse']['group']} #{node['clickhouse']['user']}) || true
  BASH
end

directory "#{node['clickhouse']['log_path']}/" do
  owner node['clickhouse']['user']
  group node['clickhouse']['group']
  recursive true
end

directory "#{node['clickhouse']['lib_path']}/" do
  owner node['clickhouse']['user']
  group node['clickhouse']['group']
  recursive true
end

directory "#{node['clickhouse']['conf_path']}/" do
  owner node['clickhouse']['user']
  group node['clickhouse']['group']
  recursive true
end

directory "#{node['clickhouse']['run_path']}/" do
  owner node['clickhouse']['user']
  group node['clickhouse']['group']
  recursive true
end

bash 'download-clickhouse' do
  user 'root'
  code <<-BASH
    cd /tmp
    
    mkdir -p /etc/apt/sources.list.d
    apt-key adv --keyserver keyserver.ubuntu.com --recv E0C56BD4
    echo "deb https://repo.clickhouse.tech/deb/stable/ main/" > /etc/apt/sources.list.d/clickhouse.list
    apt-get update
    env DEBIAN_FRONTEND=noninteractive apt-get install --allow-unauthenticated --yes --no-install-recommends \
      clickhouse-common-static=#{node['clickhouse']['version']} \
      clickhouse-client=#{node['clickhouse']['version']} \
      clickhouse-server=#{node['clickhouse']['version']}

    chown -R #{node['clickhouse']['user']}:#{node['clickhouse']['group']} #{node['clickhouse']['conf_path']}
    chown -R #{node['clickhouse']['user']}:#{node['clickhouse']['group']} #{node['clickhouse']['conf_path']}/
    chown -R #{node['clickhouse']['user']}:#{node['clickhouse']['group']} #{node['clickhouse']['log_path']}
    chown -R #{node['clickhouse']['user']}:#{node['clickhouse']['group']} #{node['clickhouse']['log_path']}/
    chown -R #{node['clickhouse']['user']}:#{node['clickhouse']['group']} #{node['clickhouse']['lib_path']}
    chown -R #{node['clickhouse']['user']}:#{node['clickhouse']['group']} #{node['clickhouse']['lib_path']}/
  BASH
end

template "#{node['clickhouse']['conf_path']}/config.xml" do
  source 'config.xml.erb'
  owner node['clickhouse']['user']
  group node['clickhouse']['group']
  mode  '0660'
end

template "#{node['clickhouse']['conf_path']}/users.xml" do
  source 'users.xml.erb'
  owner node['clickhouse']['user']
  group node['clickhouse']['group']
  mode  '0660'
end

template '/etc/security/limits.conf' do
  source 'limits.conf.erb'
  owner 'root'
  group 'root'
  mode  '0644'
end

template '/etc/systemd/system/clickhouse-server.service' do
  source 'clickhouse.service.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

execute 'systemctl daemon-reload'

execute '(systemctl enable clickhouse-server) || true'

execute '(service clickhouse-server restart) || true'
