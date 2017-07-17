#!/bin/bash
## set-aia-settings <user> <pass> <elbfqdn> <consoleport>
user=$1
pass=$2
managerfqdn=$3
consoleport=$4
manager=localhost:${4}


SID=`curl -k -H "Content-Type: application/json" -X POST "https://${manager}/rest/authentication/login/primary" -d '{"dsCredentials":{"userName":"'${user}'","password":"'${pass}'"}}'`

curl -k -v -H "Content-Type: text/xml;charset=UTF-8" -H 'SOAPAction: "systemSettingSet"' "https://${manager}/webservice/Manager" -d \
'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:Manager">'\
'<soapenv:Header/>'\
'<soapenv:Body>'\
'<urn:systemSettingSet>'\
'<urn:editableSettings>'\
'<urn:settingKey>CONFIGURATION_AGENTINITIATEDACTIVATION</urn:settingKey>'\
'<urn:settingUnit>NONE</urn:settingUnit>'\
'<urn:settingValue>1</urn:settingValue>'\
'</urn:editableSettings>'\
'<urn:editableSettings>'\
'<urn:settingKey>CONFIGURATION_AGENTINITIATEDACTIVATIONACTIVEHOST</urn:settingKey>'\
'<urn:settingUnit>NONE</urn:settingUnit>'\
'<urn:settingValue>2</urn:settingValue>'\
'<urn:settingKey>CONFIGURATION_AGENTCOMMUNICATIONS</urn:settingKey>'\
'<urn:settingUnit>NONE</urn:settingUnit>'\
'<urn:settingValue>1</urn:settingValue>'\
'</urn:editableSettings>'\
'<urn:sID>'${SID}'</urn:sID>'\
'</urn:systemSettingSet>'\
'</soapenv:Body>'\
'</soapenv:Envelope'\>

## get Base Policy policyId
policyid=$(curl -ks -H "Content-Type: text/xml;charset=UTF-8" -H 'SOAPAction: "securityProfileRetrieveByName"' "https://${manager}/webservice/Manager" -d '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:Manager"><soapenv:Header/><soapenv:Body><urn:securityProfileRetrieveByName><urn:name>Base Policy</urn:name><urn:sID>'${SID}'</urn:sID></urn:securityProfileRetrieveByName></soapenv:Body></soapenv:Envelope>' | xml_grep ID --text_only)

echo -e "policyid for Deep Security Manager Policy is $policyid\n" >> aiaSettings.log

## Set Communication Direction to Agent Initated on Base Policy
    curl -ks -H "Content-Type: text/xml;charset=UTF-8" -H 'SOAPAction: "securityProfileSettingSet"' "https://${manager}/webservice/Manager" -d \
'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:Manager">'\
'<soapenv:Header/>'\
'<soapenv:Body>'\
'<urn:securityProfileSettingSet>'\
'<urn:securityProfileID>'${policyid}'</urn:securityProfileID>'\
'<urn:editableSettings>'\
'<urn:settingKey>CONFIGURATION_AGENTCOMMUNICATIONS</urn:settingKey>'\
'<urn:settingUnit>NONE</urn:settingUnit>'\
'<urn:settingValue>1</urn:settingValue>'\
'</urn:editableSettings>'\
'<urn:sID>'${SID}'</urn:sID>'\
'</urn:securityProfileSettingSet>'\
'</soapenv:Body>'\
'</soapenv:Envelope>'

## get Deep Security Virtual Appliance policyId
policyid=$(curl -ks -H "Content-Type: text/xml;charset=UTF-8" -H 'SOAPAction: "securityProfileRetrieveByName"' "https://${manager}/webservice/Manager" -d '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:Manager"><soapenv:Header/><soapenv:Body><urn:securityProfileRetrieveByName><urn:name>Deep Security Virtual Appliance</urn:name><urn:sID>'${SID}'</urn:sID></urn:securityProfileRetrieveByName></soapenv:Body></soapenv:Envelope>' | xml_grep ID --text_only)

echo -e "policyid for Deep Security Virtual Appliance Policy is $policyid\n" >> aiaSettings.log

## Set Communication Direction to Bi-directional on DSVA policy
    curl -ks -H "Content-Type: text/xml;charset=UTF-8" -H 'SOAPAction: "securityProfileSettingSet"' "https://${manager}/webservice/Manager" -d \
'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:Manager">'\
'<soapenv:Header/>'\
'<soapenv:Body>'\
'<urn:securityProfileSettingSet>'\
'<urn:securityProfileID>'${policyid}'</urn:securityProfileID>'\
'<urn:editableSettings>'\
'<urn:settingKey>CONFIGURATION_AGENTCOMMUNICATIONS</urn:settingKey>'\
'<urn:settingUnit>NONE</urn:settingUnit>'\
'<urn:settingValue>3</urn:settingValue>'\
'</urn:editableSettings>'\
'<urn:sID>'${SID}'</urn:sID>'\
'</urn:securityProfileSettingSet>'\
'</soapenv:Body>'\
'</soapenv:Envelope>'


## log out
curl -k -X DELETE https://localhost:$4/rest/authentication/logout?sID="$SID"
exit 
