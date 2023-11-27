# Systems Manager - Automation

- Simplies common maintenance and deployment tasks on AWS and on-premise instances

- Examples: restart instances, create an AMI, EBS snapshot, etc.
- Automation Runbook - SSM Documents to define actions performed on your EC2 instances or AWS resources (pre-defined or custom)
- Can be triggered using:
    - Manually using AWS Console, AWS CLI or SDK
    - Amazon EventBridge
    - On a schedule using Maintenance Windows
    - By AWS Config for rules remediation


![Alt text](images/automation.png)