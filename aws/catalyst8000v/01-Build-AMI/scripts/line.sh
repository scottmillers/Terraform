
aws ec2 import-image   --region "us-east-1" --platform Linux --description "My Cisco 8000v OVA image" --license-type BYOL --disk-containers file://./containers_disk.json --output json --profile default



aws ec2 describe-import-image-tasks --region "us-east-1"   --import-task-ids "import-ami-0e8af37fa86c662c6" --output json  --profile default