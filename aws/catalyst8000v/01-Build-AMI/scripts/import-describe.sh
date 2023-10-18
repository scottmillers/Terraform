!#/bin/bash
# Describe the specified import image task
IMPORT_TASK_ID="import-ami-0f755952b5a5d1d70"
aws ec2 describe-import-image-tasks --region "us-east-1" --import-task-id $IMPORT_TASK_ID --output json  --profile default | jq -r .ImportImageTasks[].StatusMessage

