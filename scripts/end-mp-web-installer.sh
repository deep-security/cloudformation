#!/bin/bash
sed -i "s|/opt/trend/dsm_app/start.sh &||g" /etc/rc.local
sed -i "s|/opt/trend/dsm_app/start.sh &||g" /etc/rc.d/rc.local
for pid in $(ps -ef | grep "/opt/trend/dsm_app/start.sh" | awk '{print $2}'); do kill -9 $pid; done
kill -9 $(netstat -plnt | grep :8080 | grep python | grep -oP '(\d*)\/python' | grep -oP '(\d*)')
exit 0