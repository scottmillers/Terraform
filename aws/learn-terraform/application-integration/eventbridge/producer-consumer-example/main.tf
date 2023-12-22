provider "aws" {
  region = var.region
  # https://github.com/terraform-aws-modules/terraform-aws-eventbridge/tree/v3.0.0/examples/complete
  # Make it faster by skipping something
  # skip_metadata_api_check     = true
  #skip_region_validation      = true
  #skip_credentials_validation = true
}

# Producer
module "atmProducerLambda" {
  source                   = "terraform-aws-modules/lambda/aws"
  version                  = "~> 6.0"
  function_name            = "atmProducer"
  handler                  = "handler.lambdaHandler" # Assumes file name is index and handler is called handler
  runtime                  = "nodejs18.x"
  source_path              = "src/atmProducer"
  attach_policy_statements = true # required to attach policy statement
  policy_statements = {
    eventbridge = {
      effect    = "Allow",
      actions   = ["events:PutEvents"],
      resources = ["arn:aws:events:us-east-1:588459062833:event-bus/default"]
    },
  }

}

# Consumer Case1 
module "atmConsumerCase1Lambda" {
  source        = "terraform-aws-modules/lambda/aws"
  version       = "~> 6.0"
  function_name = "atmConsumerCase1Fn"
  handler       = "handler.case1Handler" # Assumes file name is index and handler is called handler
  runtime       = "nodejs18.x"
  source_path   = "src/atmConsumer"
}

# Consumer Case2 
module "atmConsumerCase2Lambda" {
  source        = "terraform-aws-modules/lambda/aws"
  version       = "~> 6.0"
  function_name = "atmConsumerCase2Fn"
  handler       = "handler.case2Handler" # Assumes file name is index and handler is called handler
  runtime       = "nodejs18.x"
  source_path   = "src/atmConsumer"
}


# Consumer Case3 
module "atmConsumerCase3Lambda" {
  source        = "terraform-aws-modules/lambda/aws"
  version       = "~> 6.0"
  function_name = "atmConsumerCase3Fn"
  handler       = "handler.case3Handler" # Assumes file name is index and handler is called handler
  runtime       = "nodejs18.x"
  source_path   = "src/atmConsumer"

}

module "eventbridge" {
  source               = "terraform-aws-modules/eventbridge/aws"
  create_bus           = false
  attach_lambda_policy = true
  lambda_target_arns   = [module.atmConsumerCase1Lambda.lambda_function_arn,module.atmConsumerCase2Lambda.lambda_function_arn,module.atmConsumerCase3Lambda.lambda_function_arn]
  rules = {
    atmConsumerCase1 = {
      description = "Approved Transactions"
      event_pattern = jsonencode(
        {
          "source" : ["custom.myATMapp"],
      })
    }

    atmConsumerCase2 = {
      description = "New York Transactions"
      event_pattern = jsonencode(
        {
          "source" : ["custom.myATMapp"],
          "detailtype" : ["transaction"],
          "detail" : {
            "location" : {
              "prefix" : ["NY-"]
            }
          }
      })
    }
    atmConsumerCase3 = {
      description = "Not Approved Transactions"
      event_pattern = jsonencode(
        {
          "source" : ["custom.myATMapp"],
          "detailtype" : ["transaction"],
          "detail" : {
            "result" : { "anything-but" : ["approved"] }
          }
      })
    }
  }

  targets = {
    atmConsumerCase1 = [
      {
        name = "Send Approved Transaction to Lambda Consumer Case 1"
        arn  = module.atmConsumerCase1Lambda.lambda_function_arn
      }
    ]
    atmConsumerCase2 = [
      {
        name = "Send Approved Transaction to Lambda Consumer Case 2"
        arn  = module.atmConsumerCase2Lambda.lambda_function_arn
      }
    ]

    atmConsumerCase3 = [
      {
        name = "Send Not Approved Transaction to Lambda Consumer Case 3"
        arn  = module.atmConsumerCase3Lambda.lambda_function_arn
      }

    ]
  }
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
  name                       = "${random_pet.this.id}-queue"
  sqs_managed_sse_enabled    = false
  visibility_timeout_seconds = 30    #30 seconds
  message_retention_seconds  = 86400 #1day
}

