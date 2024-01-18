#!/bin/zsh

# Set the AWS region and Lambda function name
AWS_REGION="us-west-2"
LAMBDA_FUNCTION_NAME="my-lambda-function"

# Create a new version of the Lambda function
new_version=$(aws lambda publish-version --region $AWS_REGION --function-name $LAMBDA_FUNCTION_NAME | jq -r '.Version')

# Update the live alias to point to the new version
aws lambda update-alias --region $AWS_REGION --function-name $LAMBDA_FUNCTION_NAME --name live --function-version $new_version
