# AWS Serverless Application Repository (SAR)

- Managed repository for deploying and publishing serverless applications
- You can use pre-built applications instead of cloning, building, packaging, and publishing source code to AWS before deploying it
- Each application includes an AWS SAM template that specifies the AWS resources that will be used in the application

## Publishing Applications

- To publish a serverless app, you can use the following to upload your code:
    - AWS Management Console
    - AWS SAM CLI
    - AWS SDKs

- You can deploy and share your app by setting it to:
    - Public: 
        - Available to all AWS accounts in all regions
    - Privately Shared: 
        - Shared to a specific set of AWS account
        - Accessible in the AWS Region in which they are created
        - You have permission to deploy applications shared with your AWS Account
    - Private
        - Not shared with any other AWS accounts
        - Only accessible to the AWS account that created it
        - You have permission to deploy applications created with your AWS account
        

## References

https://tutorialsdojo.com/aws-serverless-application-repository/

https://aws.amazon.com/serverless/serverlessrepo/

https://docs.aws.amazon.com/serverlessrepo/latest/devguide/what-is-serverlessrepo.html
