# Set the return values from Terraform to be used for test scripts
locals {
  variables = <<-EOT
    #!/bin/zsh
    ##
    ## variables for the ZSH shell scripts
    ##
    REMOTE_USER="ec2-user"
    PRIVATE_KEY_FILE="private_key.pem"

  
    EC2="${aws_instance.web_server_one.public_ip}"

  EOT

}

resource "local_file" "output_variables" {
  content  = local.variables
  filename = "${path.module}/scripts/variables.zsh"
}
