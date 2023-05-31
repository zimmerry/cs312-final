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
      # Execute command for argument A
      echo "Provisioning server on ec2"
      echo "terraform -chdir=terraform apply -auto-approve"
      terraform -chdir=terraform apply -auto-approve
      echo "ansible-playbook -i tf-output/ansible_inventory ansible/playbook.yml"
      ansible-playbook -i tf-output/ansible_inventory ansible/playbook.yml
      # Insert your command for Argument A here
      ;;
    stop)
      # Execute command for argument B
      echo "Stopping server and removing resources"
      echo "terraform -chdir=terraform destroy -auto-approve"
      terraform -chdir=terraform destroy -auto-approve
      # Insert your command for Argument B here
      ;;
    *)
      echo "Unknown argument: $1"
      exit 1
      ;;
  esac
  shift
done
