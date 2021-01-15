#!/bin/bash

set -e

package_file=clickhouse-$(git rev-parse --short HEAD).tar.gz

apt-get update && apt-get install -y git rsync openssh-client build-essential python-dev python-pip
gem install bundler --no-document 
bundle install
gem install berkshelf -v '~> 6.3.4'
bundle exec rake
berks package ${packageFile}