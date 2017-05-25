#!/bin/bash
mkdir -p /etc/cfn/rhel-scripts/aws-cfn-bootstrap-latest
cd /etc/cfn/rhel-scripts
curl -O https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -ivh epel-release-latest-7.noarch.rpm
yum -y install python-pip
curl -O https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz
tar -zxf aws-cfn-bootstrap-latest.tar.gz -C aws-cfn-bootstrap-latest
easy_install aws-cfn-bootstrap-latest
easy_install pip
pip install awscli
cp /etc/cfn/rhel-scripts/aws-cfn-bootstrap-latest/aws-cfn-bootstrap-1.4/init/redhat/cfn-hup /etc/init.d/cfn-hup
chmod 755 /etc/init.d/cfn-hup
chmod 775 /etc/cfn/rhel-scripts/aws-cfn-bootstrap-latest/aws-cfn-bootstrap-1.4/init/redhat/cfn-hup
mkdir -p /opt/aws/bin/
ln -s /usr/bin/cfn-hup /opt/aws/bin/cfn-hup