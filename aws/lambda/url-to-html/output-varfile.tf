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
    
    REGION=

    PROFILE = 

    S3_BUCKET_NAME=${module.bucket.s3_bucket_bucket_domain_name}

    FUNCTION_NAME=${module.lambda.lambda_function_name}

    FUNCTION_ALIAS_NAME=${module.alias.lambda_alias_name}

    FUNCTION_ALIAS_URL=${aws_lambda_function_url.live.function_url}

  EOT

}

