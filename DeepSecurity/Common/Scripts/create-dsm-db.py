#!/usr/bin/python
import pymssql
import argparse

## create-DSM-SqlDB --user {username} --pass {password} --endpoint {sql fqdn} --dbname {name of db to create}

parser = argparse.ArgumentParser()
parser.add_argument('--endpoint', action='store', dest='endpoint')
parser.add_argument('--user', action='store', dest='dbuser')
parser.add_argument('--pass', action='store', dest='dbpass')
parser.add_argument('--dbname', action='store', dest='dbname')
args = parser.parse_args()

conn = pymssql.connect(args.endpoint, args.dbuser, args.dbpass)
conn.autocommit(True)
cursor = conn.cursor()
cursor.execute("CREATE DATABASE %s" % args.dbname)
conn.close()
#done




