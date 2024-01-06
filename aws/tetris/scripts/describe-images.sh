
#!/bin/bash
# List all AMI in text
# Warning: This list is very long
aws ec2 describe-images --region us-east-2 --owners 099720109477 --query 'Images[*].[ImageId,Name]' --output text
