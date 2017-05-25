#!/bin/bash
cd /etc/cfn/rhel-scripts
curl -O https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -ivh epel-release-latest-7.noarch.rpm
yum -y install python-pip
yum -y install gcc-c++
yum -y install python-devel
yum -y install freetds-devel
pip install  pymssql
