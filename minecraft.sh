#!/bin/bash

# Check the number of command-line arguments
if [[ $# -eq 0 ]]; then
  echo "No command-line arguments provided"
  echo "Usage:"
  echo "    ./minecraft.sh start"
  echo "    ./minecraft.sh stop"
  exit 1
fi

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    start)
      echo "Provisioning server on ec2"
      terraform -chdir=terraform init
      echo "terraform apply -auto-approve"
      terraform -chdir=terraform apply -auto-approve
      sleep 90 # Sleep for 90 seconds to give the instance time to provision
      echo ""
      echo "ansible-playbook -i tf-output/ansible_inventory ansible/playbook.yml"
      ansible-playbook -i tf-output/ansible_inventory ansible/playbook.yml
      ;;
    stop)
      echo "Stopping server and removing resources"
      terraform -chdir=terraform init
      echo "terraform destroy -auto-approve"
      terraform -chdir=terraform destroy -auto-approve
      ;;
    *)
      echo "Unknown argument: $1"
      exit 1
      ;;
  esac
  shift
done
