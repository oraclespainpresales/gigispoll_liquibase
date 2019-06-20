#!/bin/bash

# Usage ./clonePDBs.sh <demozone>

export ORACLE_HOME=/u01/app/oracle/product/18.0.0.0/dbhome_1
export ORACLE_SID=DB$1
export PATH=$ORACLE_HOME/bin:$PATH


sudo -E -u oracle bash << EOF1

id

echo $1

env | grep ORACLE

ls $ORACLE_HOME | grep sqlplus

sqlplus -s system/"ZZ0r_cle#1" << EOF2
whenever sqlerror exit sql.sqlcode;
set echo off
set heading off

 drop database link clone_link_json;

 create database link clone_link_json connect to system identified by "Welcome1#Oc4j1013-" using '(DESCRIPTION = (ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = 130.61.124.136)(PORT = 1521)))(CONNECT_DATA = (SERVICE_NAME = pdbjson.sub03010825490.devopsvcn.oraclevcn.com)))';

 CREATE PLUGGABLE DATABASE pdbjson2 FROM pdbjson@clone_link_json keystore identified by "ZZ0r_cle#1";

 drop database link clone_link_sql;

 create database link clone_link_sql connect to system identified by "Welcome1#Oc4j1013-" using '(DESCRIPTION = (ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = 130.61.124.136)(PORT = 1521)))(CONNECT_DATA = (SERVICE_NAME = dodbhp_pdb1.sub03010825490.devopsvcn.oraclevcn.com)))';

 CREATE PLUGGABLE DATABASE dodbhp_pdb12 FROM dodbhp_pdb1@clone_link_sql keystore identified by "ZZ0r_cle#1";

exit;
EOF2

EOF1
