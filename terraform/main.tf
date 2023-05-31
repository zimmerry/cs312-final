terraform {
	required_providers {
		aws = {
			source  = "hashicorp/aws"
			version = "~> 4.16"
		}

		ansible = {
			source  = "ansible/ansible"
			version = "~> 1.1.0"
		}
	}

	required_version = ">= 1.2.0"
}

provider "aws" {
	region  = "us-west-2"
}

resource "aws_key_pair" "aws_ansible" {
	key_name   = "aws-ansible"
	public_key = file(var.ssh_pub_key_file)
}

# Security Group
resource "aws_security_group" "cs312_final" {
	name = "cs312-final"
	description = "CS312 MC Server"
	tags = {
		Name = "cs312-final"
	}

  ingress {
	description = "Minecraft (25565)"
	from_port   = 25565
	to_port     = 25565
	protocol    = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
	description = "SSH (22)"
	from_port   = 22
	to_port     = 22
	protocol    = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
	description = "Allow all"
	from_port   = 0
	to_port     = 0
	protocol    = "-1"
	cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "cs312_final" {
	ami           				= "ami-0744bdf45532dfd8e"
	instance_type 				= var.instance_type
	key_name 	  				= aws_key_pair.aws_ansible.key_name
  	associate_public_ip_address = true
  	vpc_security_group_ids 		= [ aws_security_group.cs312_final.id ]

	tags = {
		Name = var.instance_name
	}
}

