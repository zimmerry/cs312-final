# cs312-final
Auto-provisioning Minecraft Server on AWS

This repo contains [Terraform](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform) specifications and and an [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible) playbook that automatically provision an AWS ec2 instance, configure the instance, and start a Minecraft server using a Docker container

## Using these scripts
### Prerequisites
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible)
- [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [AWS](https://aws.amazon.com/) account
- Clone this repository
```
git clone 
cd cs312-final
```

### Generating AWS credentials
In order to interface with AWS, we need to generate some static credentials for the CLI to use.

From the AWS Console:
1. Click on your username in the top right corner
2. In the dropdown menu, click on _Security credentials_
3. Scroll down to _Access keys_ and click _Create access key_
4. Check the box under _Contine to create access key?_ and click _Create access key_
5. Create the file `~/.aws/credentials` (you may have to create the `.aws` directory), and enter the _Access key_ and _Secret access key_ like this:
```
[default]
aws_access_key_id=ACCESSKEYFROMCONSOLE
aws_secret_access_key=SECRETACCESSFROMCONSOLE
```

### Creating an 
