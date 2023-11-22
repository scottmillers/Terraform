#!/bin/bash
# Script to copy a AMI from from one AWS account to another 
#
#

# Get the source AMI ID and the destination AWS account ID from the user
#read -p "Enter the source AMI ID: " source_ami_id
#read -p "Enter the destination AWS account ID: " dest_account_id

# Use the AWS CLI to create a temporary EC2 instance in the source account using the source AMI ID
#instance_id=$(aws ec2 run-instances --image-id $source_ami_id --instance-type t2.micro --key-name my-key-pair --security-group-ids sg-xxxxxxxx --subnet-id subnet-xxxxxxxx --query 'Instances[0].InstanceId' --output text)

# Use the AWS CLI to create a new AMI from the temporary instance
#ami_name="Copy of $source_ami_id"
#new_ami_id=$(aws ec2 create-image --instance-id $instance_id --name "$ami_name" --description "Copy of $source_ami_id" --query 'ImageId' --output text)

# Use the AWS CLI to share the new AMI with the destination AWS account
#aws ec2 modify-image-attribute --image-id $new_ami_id --launch-permission "Add=[{UserId=$dest_account_id}]"

ami_name="Cisco Catalyst 8000V AMI"
new_ami_id="ami-0af0d29e399b3acc1"

# Use the AWS CLI to copy the shared AMI to the destination AWS account
#copy_ami_id=$(aws ec2 copy-image --source-image-id $new_ami_id --source-region us-east-1 --region us-east-1 --name "$ami_name"  --output text)

echo aws ec2 copy-image --source-image-id $new_ami_id --source-region us-east-1 --region us-east-1 --name "$ami_name"  --output text
# Use the AWS CLI to deregister the temporary AMI and terminate the temporary instance
#aws ec2 deregister-image --image-id $new_ami_id
#aws ec2 terminate-instances --instance-ids $instance_id
