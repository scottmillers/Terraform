# Use the output public ip addresses to create the files needed for testing
locals {
  variables = <<-EOT
    #!/bin/zsh
    ##
    ## variables for the ZSH shell scripts
    ##
    REMOTE_USER="${module.vnet-hub.vm_username}"
    PRIVATE_KEY_FILE="private_key.pem"
    HUB_VM="${module.vnet-hub.vm_public_ip_address}"
    SPOKE_VM="${module.vnet-spoke-application.vm_public_ip_address}"
    ONPREMISE_VM="${module.vnet-spoke-onpremise.vm_public_ip_address}"

  EOT

}

resource "local_file" "output_variables" {
  content  = local.variables
  filename = "${path.module}/test/variables.zsh"
}
