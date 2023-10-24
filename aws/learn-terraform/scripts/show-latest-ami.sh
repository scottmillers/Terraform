#!/bin/bash
# Get the AMI ID of the latest Amazon Linux 2 AMI
# Set the AWS region
export AWS_DEFAULT_REGION=us-east-1

 # https://github.com/seanlwatson/AWS_CLI
#aws ec2 describe-images  --owners amazon --filters "Name=name,Values=amzn2-ami-hvm-2.0.*" --query "Images | sort_by(@, &CreationDate) | [-1]"

# Get latest amazon linux amis
aws ssm get-parameters-by-path --region $AWS_DEFAULT_REGION --path /aws/service/ami-amazon-linux-latest --query "Parameters[].Name"
