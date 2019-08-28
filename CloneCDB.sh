#!/bin/bash

. ./VARS/vars.sh


terraform init Terraform
terraform plan Terraform
terraform apply -auto-approve Terraform
mkdir -p Demozones/$TF_VAR_demozone
mv terraform.tfstate Demozones/$TF_VAR_demozone
git add  Demozones/$TF_VAR_demozone
git commit -m "Developer Cloud Service Terraform Deploy $(Date) $TF_VAR_demozone"
git push -u origin master



