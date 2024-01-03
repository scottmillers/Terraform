# Output a file with variable for testing scripts

# Output a set of variables used by your scripts
resource "local_file" "output_variables" {
  content  = local.variables
  filename = "${path.module}/scripts/variables.zsh"
}

locals {
  variables = <<-EOT
    #!/bin/zsh
    ##
    ## variables for the ZSH shell scripts
    ##
    
    REMOTE_USER="${var.ec2_username}"
    PRIVATE_KEY_FILE="private_key.pem"

    SDWAN_IP="${aws_instance.controller_sdwan.public_ip}"
  EOT

}



