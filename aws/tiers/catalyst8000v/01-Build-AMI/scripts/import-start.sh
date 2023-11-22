#!/bin/bash
# Run the AWS VM image import process
# Set variables
FILE_URL="file://./containers_ova.json"
AWS_REGION="us-east-1"
AWS_PROFILE="default"

# Start Import
IMPORT_TASK_ID=$(aws ec2 import-image \
    --region $AWS_REGION \
    --architecture x86_64 \
    --platform Linux \
    --description "My Cisco 8000v OVA image" \
    --license-type BYOL \
    --disk-containers $FILE_URL \
    --output json \
    --query 'ImportTaskId' \
    --profile $AWS_PROFILE)


# Wait for import task to complete
#aws ec2 wait import-image-task-completed \
#    --region $AWS_REGION \
#    --import-task-id $IMPORT_TASK_ID \
#    --profile default
    
echo IMPORT_TASK_ID=$IMPORT_TASK_ID


#aws ec2 describe-import-image-tasks \
#    --region $AWS_REGION \
#    --import-task-id $IMPORT_TASK_ID \
#    --output text \
#    --profile $AWS_PROFILE



#echo IMPORT_IMAGE_ID=$IMPORT_IMAGE_ID