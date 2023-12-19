provider "aws" {
  region = var.region
  # https://github.com/terraform-aws-modules/terraform-aws-eventbridge/tree/v3.0.0/examples/complete
  # Make it faster by skipping something
  #skip_metadata_api_check     = true
  #skip_region_validation      = true
  #skip_credentials_validation = true
}

// Create a lambda function
// https://registry.terraform.io/modules/terraform-aws-modules/lambda/aws/latest
module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 6.0"

  function_name = "${random_pet.this.id}-lambda"
  handler       = "index.handler"  # Assumes file name is index and handler is called handler
  runtime       = "nodejs20.x"

  source_path = "src/log-schedule-events"

}



##################
# Extra resources
##################
resource "random_pet" "this" {
  length = 2
}
