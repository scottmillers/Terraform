# System Manager - Run Command

- Execute a document (=script) or just run a command
- Run command across multiple instances (using resource groups)
- No need for SSH
- Command Output can be shown in the AWS Console, sent to S3 bucket or CloudWatch Logs
- Send notifications to SNS about command status changes(In Progress, Success, Failed, Timed Out, Cancelled, etc.)
- Integrated with IAM and CloudTrail
- Can be invoked using EventBridge

![Alt text](images/run-command.png)