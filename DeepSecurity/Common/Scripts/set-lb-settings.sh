#!/bin/bash
##set-lb-settings <dsmuser> <dsmpass> <managerfqdn> <consoleport> <hbport>
user=$1
pass=$2
managerfqdn=$3
consoleport=$4
heartbeatport=$5
manager=localhost:${4}


SID=`curl -k -H "Content-Type: application/json" -X POST "https://${manager}/rest/authentication/login/primary" -d '{"dsCredentials":{"userName":"'${user}'","password":"'${pass}'"}}'`

curl -k -v -H "Content-Type: text/xml;charset=UTF-8" -H 'SOAPAction: "systemSettingSet"' "https://${manager}/webservice/Manager" -d \
'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:Manager">'\
'<soapenv:Header/>'\
'<soapenv:Body>'\
'<urn:systemSettingSet>'\
'<urn:editableSettings>'\
'<urn:settingKey>CONFIGURATION_SYSTEMLOADBALANCERHEARTBEATHOSTNAME</urn:settingKey>'\
'<urn:settingUnit>NONE</urn:settingUnit>'\
'<urn:settingValue>'${managerfqdn}'</urn:settingValue>'\
'</urn:editableSettings>'\
'<urn:editableSettings>'\
'<urn:settingKey>CONFIGURATION_SYSTEMLOADBALANCERHEARTBEATPORT</urn:settingKey>'\
'<urn:settingUnit>PORT</urn:settingUnit>'\
'<urn:settingValue>'${heartbeatport}'</urn:settingValue>'\
'</urn:editableSettings>'\
'<urn:editableSettings>'\
'<urn:settingKey>CONFIGURATION_SYSTEMLOADBALANCERMANAGERHOSTNAME</urn:settingKey>'\
'<urn:settingUnit>NONE</urn:settingUnit>'\
'<urn:settingValue>'${managerfqdn}'</urn:settingValue>'\
'</urn:editableSettings>'\
'<urn:editableSettings>'\
'<urn:settingKey>CONFIGURATION_SYSTEMLOADBALANCERMANAGERPORT</urn:settingKey>'\
'<urn:settingUnit>PORT</urn:settingUnit>'\
'<urn:settingValue>'${consoleport}'</urn:settingValue>'\
'</urn:editableSettings>'\
'<urn:editableSettings>'\
'<urn:settingKey>CONFIGURATION_SYSTEMLOADBALANCERRELAYHOSTNAME</urn:settingKey>'\
'<urn:settingUnit>NONE</urn:settingUnit>'\
'<urn:settingValue>'${managerfqdn}'</urn:settingValue>'\
'</urn:editableSettings>'\
'<urn:sID>'${SID}'</urn:sID>'\
'</urn:systemSettingSet>'\
'</soapenv:Body>'\
'</soapenv:Envelope'\>


