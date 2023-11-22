# Set the return values from Terraform to be used for test scripts
locals {
  variables = <<-EOT
    #!/bin/zsh
    ##
    ## variables for the ZSH shell scripts
    ##
    
    PRIVATE_KEY_FILE="private_key.pem"
    # Change to your login user name 
    REMOTE_USER="ec2-user"
   

   
   

    EC2_US_EAST_2="${module.ec2_us_east_2.public_ip}"

  EOT

}
# Output a set of variables used by your scripts
resource "local_file" "output_variables" {
  content  = local.variables
  filename = "${path.module}/scripts/variables.zsh"
}
