# Amazon GuardDuty

- Intelligent threat detection service to protect your AWS Account
- Uses Machine Learning to detect anomalies
- One click to enable, no need to install software
- Input data includes:
    - CloudTrail Event logs - ususual API calls, unauthorized deployments
    - VPC Flow Logs - unusual internal traffic, unusual IP addresses
    - DNS Logs - compromised EC2 instances sending traffic to known malicious domains
    - And other optional services


![GuardDuty Architecture](images/guardduty-architecture.png)
