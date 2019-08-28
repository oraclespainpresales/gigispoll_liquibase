#!/bin/bash

echo $1

sudo cp ClonePDBs.sql /home/oracle
sudo cp execDB.sh /home/oracle
sudo chown oracle:oinstall /home/oracle/ClonePDBs.sql
sudo chown oracle:oinstall /home/oracle/execDB.sh
sudo chmod +x /home/oracle/execDB.sh

sudo su -l oracle -c "/home/oracle/execDB.sh $1"

sudo rm /home/oracle/ClonePDBs.sql
