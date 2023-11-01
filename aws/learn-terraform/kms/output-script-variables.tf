# Output the values used by the encrypt and decrypt scripts
locals {
  variables = <<-EOT
    #!/bin/zsh
    ##
    ## variables for the shell scripts
    ##
    AWS_REGION="${var.region}"
    KMS_KEY_ALIAS="${aws_kms_alias.my_kms_alias.name}"


  EOT

}

resource "local_file" "output_variables" {
  content  = local.variables
  filename = "${path.module}/scripts/variables.zsh"
}
