# cs312-final
Auto-provisioning Minecraft Server on AWS

This repo contains [Terraform](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform) specifications and and an [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible) playbook that automatically provision an AWS ec2 instance, configure the instance, and start a Minecraft server using a Docker container

## Prerequisites
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible)
- [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [AWS](https://aws.amazon.com/) account

## Generating AWS credentials
