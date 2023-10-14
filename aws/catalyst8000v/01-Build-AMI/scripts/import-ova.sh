#!/bin/bash

# Set variables
FILE_URL="file://./containers.json"
AWS_REGION="us-east-1"
AMI_NAME="my-cisco8000v-ami"
INSTANCE_TYPE="t2.micro"

# Import OVA file to EC2
IMPORT_TASK_ID=$(aws ec2 import-image \
    --region $AWS_REGION \
    --architecture x86_64 \
    --platform Linux \
    --description "My Cisco 8000v OVA image" \
    --license-type BYOL \
    --disk-containers $FILE_URL \
    --output json \
    --query 'ImportTaskId' \
    --profile default)


# Wait for import task to complete
aws ec2 wait import-image-task-completed \
    --region $AWS_REGION \
    --import-task-id $IMPORT_TASK_ID \
    --profile default
    
echo IMPORT_TASK_ID=$IMPORT_TASK_ID

aws ec2 describe-import-image-tasks
# Create AMI from imported image
IMPORTED_IMAGE_ID=$(aws ec2 describe-import-image-tasks \
    --region $AWS_REGION \
    --import-task-ids $IMPORT_TASK_ID \
    --query 'ImportImageTasks[0].ImageId' \
    --output text \
    --profile default)


echo IMPORT_IMAGE_ID=$IMPORT_IMAGE_ID