# frozen_string_literal: true

default['base_packages'] = %w[
  zip
  unzip
  curl
  openssh-server
  ca-certificates
  apt-transport-https
  wget
  jq
  dirmngr
  locales
]
default['custom_packages']            = []

default['application']                = 'clickhouse'
