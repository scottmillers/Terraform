# Wait for snapshot completion
while true; do
  import_task_status_command="aws ec2 describe-import-snapshot-tasks --import-task-ids ${import_task_id} --query 'ImportSnapshotTasks[0].SnapshotTaskDetail.Status' --output text"
  echo "Running command: ${import_task_status_command}"
  import_task_status=$(${import_task_status_command})
  echo "Import task [${import_task_id}] status is [${import_task_status}]."

  if [[ "$import_task_status" == "completed" ]]; then
    echo "Completed, exiting..."
    break
  elif [[ "$import_task_status" == "pending" ]]; then
    echo "Waiting 1 minute..."
    sleep 60
  else
    echo "Error, exiting..."
    exit 1
  fi
done