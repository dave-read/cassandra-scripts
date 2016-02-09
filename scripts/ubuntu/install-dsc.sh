#!/usr/bin/env bash

DIR="$(cd "$(dirname "$0")" && pwd)"
CASSANDRA_VERSION="2.1.12"
DSC_VERSION="$CASSANDRA_VERSION-1"

if [ $EUID -ne 0 ];then
        echo "You must have root privilege to run this script"
        exit 1
fi

$DIR/install-dsc-repo.sh

apt-get update
INSTALL_RESULT=$(apt-get -y install dsc21=$DSC_VERSION cassandra=$CASSANDRA_VERSION | tee /dev/tty)
TOOLS_RESULT=$(apt-get -y install cassandra-tools=$CASSANDRA_VERSION | tee /dev/tty)


# Remove the default cluster_name TEST Cluster
# alternative to tee to /dev/tty would be 
#
# exec 5>&1 
# $( cmd | tee /dev/fd/5 
if [[ "$INSTALL_RESULT" == *"2 newly installed"* ]]; then
	echo "New install removing default cluster configuration"
	echo "Stopping service ..."
	service cassandra stop
	echo "Stopping service done"
	echo "Removing system tables ..."
	rm -rf /var/lib/cassandra/data/system
	echo "Removing system tables done"
else
	echo "Installation was an update so not removing system tables"
fi




