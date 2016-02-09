#!/usr/bin/env bash

DIR="$(cd "$(dirname "$0")" && pwd)"
CASSANDRA_VERSION="2.1.12"
DSC_VERSION="$CASSANDRA_VERSION-1"

if [ $EUID -ne 0 ];then
        echo "You must have root privilege to run this script"
        exit 1
fi

sh $DIR/install-java.sh
sh $DIR/install-dsc-repo.sh

apt-get install -y opscenter

# Enable security and set auto start
sh $DIR/update-dsc-ops-cfg.sh
service opscenterd stop
update-rc.d opscenterd defaults
service opscenterd start

