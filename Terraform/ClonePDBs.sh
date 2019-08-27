#!/bin/bash

echo $1

export ORACLE_SID=DB$1
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=/u01/app/oracle/product/18.0.0.0/dbhome_1

LOWERHOST=$(echo "$1" | tr '[:upper:]' '[:lower:]')

export ORACLE_HOST=hostdb$LOWERHOST

env | grep ORACLE

sudo cp ClonePDBs.sql /home/oracle 
sudo chown oracle:oinstall /home/oracle/ClonePDBs.sql
sudo su -m -l oracle -c "sqlplus -S / as sysdba @ClonePDBs.sql"

sudo su -m -l oracle -c "impdp system/"Welcome1#Oc4j1013-"@$ORACLE_HOST:1521/dodbhp_pdb1.sub03010825490.devopsvcn.oraclevcn.com directory=DATA_PUMP_DIR logfile=microservice.log schemas=MICROSERVICE   network_link=clone_link_sql"

sudo su -m -l oracle -c "impdp system/"Welcome1#Oc4j1013-"@$ORACLE_HOST:1521/pdbjson.sub03010825490.devopsvcn.oraclevcn.com directory=DATA_PUMP_DIR logfile=microservice.log schemas=MICROSERVICE network_link=clone_link_json"

sudo rm /home/oracle/ClonePDBs.sql
