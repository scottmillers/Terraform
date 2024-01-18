provider "aws" {
  region = var.region

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true

}


/*
  This module creates an S3 bucket for storing objects used by the Lambda function "url-to-html".
  The bucket is configured with private access control and object ownership set to "ObjectWriter".
  Versioning is enabled for the bucket, and it can be forcefully destroyed even if it has objects.
*/
module "bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = var.bucket_name
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  force_destroy = true # delete the bucket even if it has objects
  versioning = {
    enabled = true
  }
}



/*
  This module creates an AWS Lambda function that converts a URL to HTML content.
*/
module "lambda" {
  source        = "terraform-aws-modules/lambda/aws"
  version       = "~> 6.0"
  function_name = var.lambda_function_name
  handler       = "index.handler"
  runtime       = "nodejs20.x"
  source_path   = "src"
  attach_policy_statements = true
  policy_statements = {
    dynamodb = {
      effect = "Allow"
      actions = [
        "s3:FullAccess",
      ],
      resources = [module.bucket.s3_bucket_arn]
    }
  }
}

/*
  This module creates an AWS Lambda function that converts a URL to HTML content.
*/
module "alias" {
  source           = "terraform-aws-modules/lambda/aws//modules/alias"
  refresh_alias    = false
  name             = var.lambda_alias_name
  function_name    = module.lambda.lambda_function_name
  function_version = module.lambda.lambda_function_version

}


resource "aws_lambda_function_url" "live" {
  function_name      = module.lambda.lambda_function_name
  authorization_type = "NONE"
  qualifier = var.lambda_alias_name
}




