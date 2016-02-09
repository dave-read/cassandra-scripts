#!/usr/bin/env bash

SRC_LIST="/etc/apt/sources.list.d/cassandra.sources.list" 
REPO_ENTRY="deb http://debian.datastax.com/community stable main"

if [ $EUID -ne 0 ];then
        echo "You must have root privilege to run this script"
        exit 1
fi

if [ ! -f $SRC_LIST ] ||  ! grep -q "debian.datastax.com" $SRC_LIST 
then
	echo "Adding DataStax repository to $SRC_LIST"
	echo $REPO_ENTRY | sudo tee -a $SRC_LIST
	echo "Adding repo key"
	curl -L http://debian.datastax.com/debian/repo_key | apt-key add -
else
	echo "Cassandra src list already exists:$SRC_LIST"
fi

apt-get update




