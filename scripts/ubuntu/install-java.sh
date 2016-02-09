#!/usr/bin/env bash 

if [ $EUID -ne 0 ];then
	echo "You must have root privilege to run this script"
	exit 1
fi
JAVA_VERSION=$(java -version 2>&1)
if [ $? -eq 0 ];then
	echo "JAVA_VERSION $JAVA_VERSION"
	if [[ "$JAVA_VERSION" == *"java version"*"1.8"* && "$JAVA_VERSION" != *"OpenJDK"* ]];then
		echo "Java 8 is already installed"
		exit 0	
	fi
fi
echo "Installing java ..."
add-apt-repository -y ppa:webupd8team/java
apt-get -y update 
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
apt-get -y install oracle-java8-installer
echo "Done"

