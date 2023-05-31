variable "instance_name" {
    description = "Value of the Name tag for the EC2 instance"
    type        = string
    default     = "cs312-final"
}

variable "instance_type" {
    description = "EC2 instance type"
    type = string
    default = "t2.medium"
}

variable "ssh_user_name" {
    description = "SSH username"
    type = string
    default = "admin"
}

variable "ssh_pub_key_file" {
  description = "SSH public key file"
  type = string
  default = "../aws-ansible.pub"
}
