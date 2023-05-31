# cs312-final
Auto-provisioning Minecraft Server on AWS

This repo contains [Terraform](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform) specifications and and an [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible) playbook that automatically provision an AWS EC2 instance, configure the instance, and start a Minecraft server using a Docker container

### Overview
![Untitled drawing](https://github.com/zimmerry/cs312-final/assets/53264075/3f116082-d4f7-4d40-901f-2a8963885b97)

## Requirements
### Prerequisites
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible)
- [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [AWS](https://aws.amazon.com/) account
- Clone this repository:
```
git clone git@github.com:zimmerry/cs312-final.git
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

### Creating an SSH Key pair
You will need an SSH key pair for Ansible to use to access the instance.

- If you don't know how to create an SSH key pair, you can follow [this guide from GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- The public key should be named `aws-ansible.pub` and the private key should be named `aws-ansible`
- Add the public and private key to the root directory of your cloned version of this repository
  - After adding the key pair, the repo should look like this:

```
├── ansible/
├── aws-ansible
├── aws-ansible.pub
├── minecraft.sh
├── README.md
├── terraform/
└── tf-output
```

## Running the scripts

To provision and start the server, run:
```
./minecraft.sh start
```
This command runs `terraform apply` which:
- Creates the VPC
- Creates the security group with port 22 (SSH) and 25565 (Minecraft) open
- Creates the EC2 instance running debian
- Creates an Ansible inventory file at `tf-output/ansible-inventory` using the information of the newly-created instance

Next it runs `ansible-playbook ansible/playbook.yml` which:
- Connects to the EC2 instance via SSH
- Installs Docker and all its dependencies
- Sets up Docker to start at boot
- Sets up a single-node Docker Swarm
- Deploys the Minecraft server

To stop the server and destroy all the resources, run:
```
./minecraft.sh stop
```

This command runs `terraform destroy` which removes all of the resources created by `terraform apply`
