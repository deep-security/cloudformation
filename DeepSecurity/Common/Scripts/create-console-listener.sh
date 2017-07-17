#!/bin/bash
## create listenter on elb
## createlistener <elb name> <elb fqdn> <dsm console port> <StackName> <firstelb>
if [ $5 -eq 1 ]; then
  openssl req -nodes -new -sha256 -newkey rsa:2048 -subj '/CN='DeepSecurityManager'/O=Trend Micro/OU=Deep Security Manager' -keyout /etc/cfn/privatekey -out /etc/cfn/csr;
  openssl x509 -req -days 3650 -in /etc/cfn/csr -signkey /etc/cfn/privatekey -out /etc/cfn/certificatebody;
  aws iam upload-server-certificate --server-certificate-name DeepSecurityElbCertificate-$4 --certificate-body file:///etc/cfn/certificatebody --private-key file:///etc/cfn/privatekey --region $6
fi

loop=1

certid=" "
until [ -n "$certid" -a "$certid" != " " ]
do
  if [ $loop -eq 1 ]; then echo 'checking for cert availability in iam'; else echo 'cert not yet available in iam'; fi
  loop=$((loop+1))
  sleep 10
  certid=$(aws iam get-server-certificate --server-certificate-name DeepSecurityElbCertificate-$4 --query ServerCertificate.ServerCertificateMetadata.Arn --output text --region $6)
done

loadbalancer=" "
loop=1

until [ -n "$loadbalancercert" -a "$loadbalancercert" != " " ]
do
  if [ $loop -eq 1 ]; then echo 'attempting to create listener'; else echo 'listener not yet created, retrying command'; fi
  loop=$((loop+1))
  sleep 10
  aws elb create-load-balancer-listeners --load-balancer-name $1 --region $6 --listeners Protocol=HTTPS,LoadBalancerPort=$3,InstanceProtocol=HTTPS,InstancePort=$3,SSLCertificateId=$certid
  loadbalancercert=$(aws elb describe-load-balancers --load-balancer-name $1 --region $6 --query 'LoadBalancerDescriptions[*].ListenerDescriptions[*].Listener.[SSLCertificateId]' --output text | grep $certid)
done

echo 'load balancer listener created'

aws elb create-load-balancer-policy --load-balancer-name $1 --policy-name DSMConsoleStickySessions --policy-type-name LBCookieStickinessPolicyType --region $6 --policy-attributes AttributeName=CookieExpirationPeriod,AttributeValue=600
aws elb set-load-balancer-policies-of-listener --load-balancer-name $1 --load-balancer-port $3 --policy-names DSMConsoleStickySessions --region $6
