# X-Ray

- Visual analysis of your application
- Troubleshoot performance issues and errors
- Understand dependencies in microservice architectures
- Pinpoint service issues
- Review request behavior
- Find errors and exceptions
- Are we meeting time SLAs?

## X-Ray Compatibility

- Lambda
- Elastic Beanstalk
- ECS
- ELB
- API Gateway
- EC2 Instances (even on-premises)

## X-Ray How to enable it?

1. You code (Java, Python, Node.js, Go, .NET, Ruby, PHP, C++) must import the AWS X-Ray SDK
    - Very little code modifications needed
    - The application SDK will capture:
        - Calls to AWS services
        - HTTP/HTTPS requests
        - Database calls (MySQL, PostgreSQL, DynamoDB, etc...)
        - Queue calls (SQS, SNS, etc...)
        - AWS Lambda functions
        - Any other calls to downstream microservices
2.  Install the X-Ray daemon or enable X-Ray AWS Integration
    - X-Ray daemon is available for Linux, Windows, Mac OS, and ARM
    - Works as a low level UDP packet interceptor
    - AWS Lambda has X-Ray built-in
    - Each application must have the IAM rights to write data to X-Ray


## X-Ray Troubleshooting

- If X-Ray is not working on EC2
    - Ensure the EC2 IAM role has the proper permissions
    - Ensure the EC2 instance is running the X-Ray daemon
- To enable on AWS Lambda
    - Ensure the Lambda function has the proper IAM permissions (AWS X-Ray Write Access)
    - Ensure the Lambda function has X-Ray Active Tracing enabled