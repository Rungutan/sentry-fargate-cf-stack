#!/bin/bash

set -e

package_file=clickhouse-$(git rev-parse --short HEAD).tar.gz

rm -f script.sh
docker rm -f rb

cat <<SCRIPT >> script.sh
#!/bin/bash

set -e
apt-get update && apt-get install -y git rsync openssh-client build-essential python-dev python-pip
gem install bundler --no-document 
bundle install
gem install berkshelf -v '~> 6.3.4'
berks package package.tar.gz
SCRIPT

chmod +x script.sh

docker run --name=rb -tid --entrypoint=""  -u root -v ${PWD}:/project --workdir=/project ruby:2.5.3 bash

docker cp script.sh rb:/project/script.sh

docker exec rb /project/script.sh

docker cp rb:/project/package.tar.gz ${package_file}

docker rm -f rb

