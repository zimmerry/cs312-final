# the allocated public IP
output "cs312_final_ip" {
  value = aws_instance.cs312_final.public_ip
}

# the allocated public DNS
output "cs312_final_dns" {
  value = aws_instance.cs312_final.public_dns
}

# process Ansible inventory template
data "template_file" "ansible_inventory" {
  template = file("ansible_inventory.tpl")
  vars = {
    cs312_final-dns = aws_instance.cs312_final.public_dns
    cs312_final-ip = aws_instance.cs312_final.public_ip
    ssh_user = var.ssh_user_name
  }
}

# generate the Ansible inventory file (in './tf-output' directory, that is stored as a job artifact)
resource "local_file" "ansible_inventory" {
  content = data.template_file.ansible_inventory.rendered
  filename = "../tf-output/ansible_inventory"
}

# process 'terraform.env' template
# tflint-ignore: terraform_required_providers
data "template_file" "terraform_dotenv" {
  template = file("terraform.env.tpl")
  vars = {
    tf_public_ip = aws_instance.cs312_final.public_ip
    tf_public_dns = aws_instance.cs312_final.public_dns
  }
}

# generate the 'terraform.env' file to propagate required variables (public IP address, env name & type)
# tflint-ignore: terraform_required_providers
resource "local_file" "terraform_dotenv" {
  content = data.template_file.terraform_dotenv.rendered
  filename = "terraform.env"
}
