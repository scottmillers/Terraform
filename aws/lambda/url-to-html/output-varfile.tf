# Output a file with variable for scripts
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
    REGION=${var.region}
    FUNCTION_NAME=${module.lambda.lambda_function_name}
        
    S3_BUCKET_DOMAIN_NAME=${module.bucket.s3_bucket_bucket_domain_name}

    PROD_ALIAS_NAME=${aws_lambda_function_url.prod_url.qualifier}
    PROD_ALIAS_URL=${aws_lambda_function_url.prod_url.function_url}

    LATEST_ALIAS_NAME=${aws_lambda_function_url.latest_url.qualifier}
    LATEST_ALIAS_URL=${aws_lambda_function_url.latest_url.function_url}

  EOT

}