#!/bin/bash
# Get the AMI ID of the latest Amazon Linux 2 AMI
# Set the AWS region
export AWS_DEFAULT_REGION=us-east-1
 
aws ec2 describe-images --region $AWS_DEFAULT_REGION --owners amazon --filters "Name=name,Values=amzn2-ami-hvm-2.0.*" --query "Images | sort_by(@, &CreationDate) | [-1]"

