#!/bin/bash
mkdir -p /etc/cfn/rhel-scripts/aws-cfn-bootstrap-latest
cd /etc/cfn/rhel-scripts
curl -O https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -ivh epel-release-latest-7.noarch.rpm
yum -y install python3
curl -O https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-py3-latest.tar.gz
tar -zxf aws-cfn-bootstrap-py3-latest.tar.gz -C aws-cfn-bootstrap-latest/
easy_install-3.6 --script-dir /opt/aws/bin https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-py3-latest.tar.gz
pip3 install awscli
cp /etc/cfn/rhel-scripts/aws-cfn-bootstrap-latest/aws-cfn-bootstrap-2.0/init/redhat/cfn-hup /etc/init.d/cfn-hup
chmod 755 /etc/init.d/cfn-hup
chmod 775 /etc/cfn/rhel-scripts/aws-cfn-bootstrap-latest/aws-cfn-bootstrap-2.0/init/redhat/cfn-hup
ln -s /opt/aws/bin/cfn-hup /usr/bin/cfn-hup
ln -s /opt/aws/bin/cfn-signal /usr/bin/cfn-signal
ln -s /opt/aws/bin/cfn-init /usr/bin/cfn-init
ln -s /opt/aws/bin/cfn-get-metadata /usr/bin/cfn-get-metadata
ln -s /opt/aws/bin/cfn-send-cmd-event /usr/bin/cfn-send-cmd-event
ln -s /opt/aws/bin/cfn-send-cmd-result /usr/bin/cfn-send-cmd-resul