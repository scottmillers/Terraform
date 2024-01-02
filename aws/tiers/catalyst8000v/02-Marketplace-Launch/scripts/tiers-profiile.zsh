#!/bin/zsh

# Set the AWS profile name
profile_name="tiers"

# Set the AWS access key ID and secret access key
#access_key="YOUR_ACCESS_KEY"
#secret_key="YOUR_SECRET_KEY"

# Set the AWS region
#region="us-east-2"

# Configure the AWS profile
aws configure --profile $profile_name

#aws configure set aws_access_key_id $access_key --profile $profile_name
#aws configure set aws_secret_access_key $secret_key --profile $profile_name
#aws configure set region $region --profile $profile_name

#echo "AWS profile $profile_name configured successfully."
