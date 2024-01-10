#!/bin/bash
# Cancel all import tasks 
aws ec2 describe-import-image-tasks  --output json  --profile default | jq -r '.ImportImageTasks[].ImportTaskId' | xargs -I {} aws ec2 delete-import-task --profile default --import-task-id  {}
