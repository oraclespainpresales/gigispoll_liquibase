﻿#!/bin/bash

. ./VARS/vars.sh


terraform init Terraform
terraform plan Terraform
terraform apply -auto-approve Terraform
terraform output -json instance_ips | jq '.value[0]' > ip_$TF_VAR_demozone.json
mkdir -p Demozones/$TF_VAR_demozone
mv terraform.tfstate Demozones/$TF_VAR_demozone
mv ip_$TF_VAR_demozone.json Demozones/$TF_VAR_demozone
git add  Demozones/$TF_VAR_demozone
git commit -m "Developer Cloud Service Terraform Deploy $(Date) $TF_VAR_demozone"
git push -u origin master



