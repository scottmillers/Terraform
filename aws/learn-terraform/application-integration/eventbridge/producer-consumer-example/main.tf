provider "aws" {
  region = var.region
  # https://github.com/terraform-aws-modules/terraform-aws-eventbridge/tree/v3.0.0/examples/complete
  # Make it faster by skipping something
  # skip_metadata_api_check     = true
  #skip_region_validation      = true
  #skip_credentials_validation = true
}

module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 6.0"

  function_name = "atm-producer-lambda"
  handler       = "handler.lambdaHandler"  # Assumes file name is index and handler is called handler
  runtime       = "nodejs18.x"
  source_path   = "src/atmProducer"
  policy_statements = {
      dynamodb = {
        effect    = "Allow",
        actions   = ["events:PutEvents"],
        resources = ["*"]
      },
  }
  #    s3_read = {
  #      effect    = "Deny",
  #      actions   = ["s3:HeadObject", "s3:GetObject"],
  #      resources = ["arn:aws:s3:::my-bucket/*"]
  #    }
  
}

// Create a lambda function
// https://registry.terraform.io/modules/terraform-aws-modules/lambda/aws/latest
/*module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 6.0"

  function_name = "${random_pet.this.id}-lambda"
  handler       = "index.handler"  # Assumes file name is index and handler is called handler
  runtime       = "nodejs20.x"
  source_path   = "src/log-schedule-events"

}
*/
/*
module "eventbridge" {
  source = "terraform-aws-modules/eventbridge/aws"

  create_bus = false
   
  attach_sqs_policy = true
  sqs_target_arns = [
    aws_sqs_queue.queue.arn
  ]

  rules = {
    processing = {
      description   = "Capture the LogSchedule Event"
      event_pattern = jsonencode({ "detail-type" : ["customerCreated"] })
    }
  }

  targets = {
    processing = [
      {
        name  = "SendLogScheduleEventToSQS"
        arn   = aws_sqs_queue.queue.arn
      }

    ]
  }
}
*/



##################
# Extra resources
##################
resource "random_pet" "this" {
  length = 2
}

resource "aws_sqs_queue" "queue" {
  name = "${random_pet.this.id}-queue"
  sqs_managed_sse_enabled = false
  visibility_timeout_seconds = 30 #30 seconds
  message_retention_seconds = 86400 #1day
}

