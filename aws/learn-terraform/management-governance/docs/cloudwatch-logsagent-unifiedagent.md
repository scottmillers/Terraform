# Cloudwatch Logs Agent & Unified Agent

- For virtual servers (EC2 instances, on-premises servers, etc.)
- Cloudwatch Logs Agent
    - Old version of the agent
    - Can only send to CloudWatch Logs

-CW Unified Agent
    - New version of the agent
    - Collects additional system-level metrics such as RAM, processes, etc
    - Collect logs to send to CloudWatch Logs
    - Centralized configuration using SSM Parameter Store