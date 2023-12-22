provider "aws" {
  region = var.region
  # https://github.com/terraform-aws-modules/terraform-aws-eventbridge/tree/v3.0.0/examples/complete
  # Make it faster by skipping something
  # skip_metadata_api_check     = true
  #skip_region_validation      = true
  #skip_credentials_validation = true
  # https://github.com/aws-samples/amazon-eventbridge-producer-consumer-example/blob/master/template.yaml
}

# Producer
module "lambda_producer" {
  source                   = "terraform-aws-modules/lambda/aws"
  version                  = "~> 6.0"
  function_name            = "atm-producer"
  handler                  = "handler.lambdaHandler" # Assumes file name is index and handler is called handler
  runtime                  = "nodejs18.x"
  source_path              = "src/atmProducer"
  attach_policy_statements = true # required to attach policy statement
  policy_statements = {
    eventbridge = {
      effect    = "Allow",
      actions   = ["events:PutEvents"],
      resources = ["arn:aws:events:us-east-1:588459062833:event-bus/default"]
      #resources = [module.eventbridge.eventbridge_bus_arn] 
    },
  }

}

# Consumer 1
module "lambda_consumer1" {
  source        = "terraform-aws-modules/lambda/aws"
  version       = "~> 6.0"
  function_name = "atm-consumer-1"
  handler       = "handler.case1Handler" # Assumes file name is index and handler is called handler
  runtime       = "nodejs18.x"
  source_path   = "src/atmConsumer"
  allowed_triggers = {
    EventBridgeRule = {
      principal  = "events.amazonaws.com"
      source_arn = module.eventbridge.eventbridge_rule_arns["consumer1"]
    }
  }
}

module "eventbridge" {
  source               = "terraform-aws-modules/eventbridge/aws"
  create_bus           = true
  bus_name = "atm-transaction-bus"
  #attach_cloudwatch_policy = true
  cloudwatch_target_arns   = [aws_cloudwatch_log_group.this.arn]
  rules = {
    consumer1 = {
      description = "Approved Transactions "
      event_pattern = jsonencode(
        {
          "source" : ["custom.myATMapp"],
      })
    }
  }

  targets = {
    consumer1 = [
      {
        name = "Send Approved Transaction to Lambda Consumer Case 1"
        arn  = module.lambda_consumer1.lambda_function_arn
      }
    ]
    
  }
}
/*
# Consumer 2
module "lambda_consumer2" {
  source        = "terraform-aws-modules/lambda/aws"
  version       = "~> 6.0"
  function_name = "atm-consumer-2"
  handler       = "handler.case2Handler" # Assumes file name is index and handler is called handler
  runtime       = "nodejs18.x"
  source_path   = "src/atmConsumer"
  allowed_triggers = {
    EventBridgeRule = {
      principal  = "events.amazonaws.com"
      source_arn = module.eventbridge.eventbridge_rule_arns["consumer2"]
    }
  }
}


# Consumer 3
module "lambda_consumer3" {
  source        = "terraform-aws-modules/lambda/aws"
  version       = "~> 6.0"
  function_name = "atm-consumer-3"
  handler       = "handler.case3Handler" # Assumes file name is index and handler is called handler
  runtime       = "nodejs18.x"
  source_path   = "src/atmConsumer"
  allowed_triggers = {
    EventBridgeRule = {
      principal  = "events.amazonaws.com"
      source_arn = module.eventbridge.eventbridge_rule_arns["consumer3"]
    }
  }

}

module "eventbridge" {
  source               = "terraform-aws-modules/eventbridge/aws"
  create_bus           = false
  attach_lambda_policy = true
  lambda_target_arns   = [module.lambda_consumer1.lambda_function_arn,module.lambda_consumer2.lambda_function_arn,module.lambda_consumer3.lambda_function_arn]
  rules = {
    consumer1 = {
      description = "Approved Transactions "
      event_pattern = jsonencode(
        {
          "source" : ["custom.myATMapp"],
      })
    }

    consumer2 = {
      description = "Location New York Transactions"
      event_pattern = jsonencode(
        {
          "source" : ["custom.myATMapp"],
          "detail-type" : ["transaction"],
          "detail" : {
            "location" : {
              "prefix" : ["NY-"]
            }
          }
      })
    }
    consumer3 = {
      description = "Not Approved Transactions"
      event_pattern = jsonencode(
        {
          "source" : ["custom.myATMapp"],
          "detail-type" : ["transaction"],
          "detail" : {
            "result" : { "anything-but" : ["approved"] }
          }
      })
    }
  }

  targets = {
    consumer1 = [
      {
        name = "Send Approved Transaction to Lambda Consumer Case 1"
        arn  = module.lambda_consumer1.lambda_function_arn
      }
    ]
    consumer2 = [
      {
        name = "Send Approved Transaction to Lambda Consumer Case 2"
        arn  = module.lambda_consumer2.lambda_function_arn
      }
    ]

    consumer3 = [
      {
        name = "Send Not Approved Transaction to Lambda Consumer Case 3"
        arn  = module.lambda_consumer3.lambda_function_arn
      }

    ]
  }
}
*/

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

