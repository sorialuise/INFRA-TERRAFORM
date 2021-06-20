#!/bin/bash
sudo yum install -y htop
#sudo touch /etc/yum.repos.d/mongodb-org-3.4.repo
#sudo touch /etc/yum.repos.d/mongodb-org-4.4.repo
sudo touch /etc/yum.repos.d/mongodb-org-4.0.repo

# sudo echo -e "[mongodb-org-3.4]
# name=MongoDB 3.4 Repository
# baseurl=https://repo.mongodb.org/yum/amazon/2013.03/mongodb-org/3.4/x86_64/
# gpgcheck=0
# enabled=1" >> /etc/yum.repos.d/mongodb-org-3.4.repo

# sudo echo -e "[mongodb-org-4.4]
# name=MongoDB Repository
# baseurl=https://repo.mongodb.org/yum/amazon/2/mongodb-org/4.4/x86_64/
# gpgcheck=1
# enabled=1
# gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc" >> /etc/yum.repos.d/mongodb-org-4.4.repo

sudo echo -e "[mongodb-org-4.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2/mongodb-org/4.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc" >> /etc/yum.repos.d/mongodb-org-4.0.repo


sudo yum install -y mongodb-org


#sudo yum install -y mongodb-org-3.6.21 mongodb-org-server-3.6.21 mongodb-org-shell-3.6.21 mongodb-org-mongos-3.6.21 mongodb-org-tools-3.6.21
#sudo yum install -y mongodb-org-4.4.2 mongodb-org-server-4.4.2 mongodb-org-shell-4.4.2 mongodb-org-mongos-4.4.2 mongodb-org-tools-4.4.2

sudo yum install -y mongodb-org-4.0.23 mongodb-org-server-4.0.23 mongodb-org-shell-4.0.23 mongodb-org-mongos-4.0.23 mongodb-org-tools-4.0.23

sudo systemctl start mongod

sudo systemctl enable mongod

mongo <<EOF
use admin
db.createUser({ user: 'admin', pwd: 'admin', roles: [ { role: "root", db: "admin" } ] })
use admin
db.auth('admin','admin')
use dbtest
db.test.save({titulo:'Batman el caballero oscuro'})
db.createUser({ user: 'test', pwd: 'A1234567$', roles: [ { role: "dbOwner", db: "dbtest" } ] })
quit()
EOF

##################################################################################################

# sudo crontab -e <<EOF
# ######
# :wq!
# EOF


# #!/bin/bash

# --schedule-expression "cron(0 2 ? * SUN *)"

# sudo echo -e "
# ############## Tareas Programadas ###########
# */1 * * * * wget www.gmail.com > /dataweb/test6.log 2>&1
# */1 * * * * wget -I www.youtube.com > /dataweb/test7.log 2>&1
# */1 * * * * wget -I www.hotmail.com > /dataweb/test8.log 2>&1
# " >> /var/spool/cron/root
# ############################################################################################################
# #!/bin/bash
# wget www.gmail.com > /tmp/testlog/testcron.log 2>&1



# #upload s3 script.sh
# aws s3 cp scripts/restoretmp.sh s3://glr-infra/jenkins/jobs/update-bd-mongo-prod-to-qa/restorebdcronos.sh 

# #download script.sh
# aws ssm send-command --instance-ids "i-00f99ec582cf5c8ee" --document-name "AWS-RunShellScript" \
#          --comment "Download Script" --parameters commands='aws s3 cp s3://glr-infra/jenkins/jobs/update-bd-mongo-prod-to-qa/restorebdcronos.sh  /tmp' \
#          --output text --query "Command.CommandId" --region us-east-1

# sleep 10s
# #run script.sh
# aws ssm send-command --instance-ids "i-00f99ec582cf5c8ee" --document-name "AWS-RunShellScript" \
#          --comment "Run Script" --parameters commands='sh /tmp/restorebdcronos.sh  > /tmp/salida-bdcronos.txt' \
#          --output text --query "Command.CommandId" --region us-east-1

# sleep 3m
# #rm scripts/restoretmp.sh
# aws ssm send-command --instance-ids "i-00f99ec582cf5c8ee" --document-name "AWS-RunShellScript" \
#          --comment "Remove Script" --parameters commands='rm -f /tmp/restorebdcronos.sh ' \
#          --output text --query "Command.CommandId" --region us-east-1




########################################################################################################################

# rm -rf /etc/mongod.conf

# sudo echo -e "# mongod.conf
# # for documentation of all options, see:
# #   http://docs.mongodb.org/manual/reference/configuration-options/

# # where to write logging data.
# systemLog:
#   destination: file
#   logAppend: true
#   path: /var/log/mongodb/mongod.log

# # Where and how to store data.
# storage:
#   dbPath: /var/lib/mongo
#   journal:
#     enabled: true
# #  engine:
# #  wiredTiger:

# # how the process runs
# processManagement:
#   fork: true  # fork and run in background
#   pidFilePath: /var/run/mongodb/mongod.pid  # location of pidfile
#   timeZoneInfo: /usr/share/zoneinfo

# # network interfaces
# net:
#   port: 27018
#   bindIp: 0.0.0.0  # Enter 0.0.0.0,:: to bind to all IPv4 and IPv6 addresses or, alternatively, use the net.bindIpAll setting.


# security:
#     authorization: enabled

# #operationProfiling:

# #replication:

# #sharding:

# ## Enterprise-Only Options

# #auditLog:

# #snmp:" >> /etc/mongod.conf 

# sudo systemctl stop mongod
# sudo systemctl restart mongod