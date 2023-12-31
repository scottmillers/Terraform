provider "aws" {
  region = var.region

  # Make it faster by skipping something
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_credentials_validation = true

}


// Lambda to get events from EventBridge
module "lambda_consumer1" {
  source        = "terraform-aws-modules/lambda/aws"
  version       = "~> 6.0"
  function_name = "consumer1"
  handler       = "handler.lambdaHandler" # Assumes file name is index and handler is called handler
  runtime       = "nodejs20.x"
  source_path   = "src"
  attach_policy_statements = true # required to attach policy statement
  policy_statements = {
    dynamodb = {
      effect = "Allow"
      actions = [
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:DeleteItem"
      ],
      resources = [aws_dynamodb_table.approved_transaction_table.arn]
    }
  }

}

// A Lambda alias is required by the Terraform EventBridge module
module "lambda_consumer1_alias" {
  source           = "terraform-aws-modules/lambda/aws//modules/alias"
  refresh_alias    = false
  name             = "latest"
  function_name    = module.lambda_consumer1.lambda_function_name
  function_version = module.lambda_consumer1.lambda_function_version

  allowed_triggers = {
    EventBridgeRule = {
      principal  = "events.amazonaws.com"
      source_arn = module.eventbridge.eventbridge_rule_arns["consumer1"]
    }
  }
}
