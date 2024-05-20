# ScoreKeep Sample Application

Explore the sample application

The sample application is an HTTP web API in Java that is configured to use the X-Ray SDK for Java. When you deploy the application with the CloudFormation template, it creates the DynamoDB tables, Amazon ECS Cluster, and other services required to run Scorekeep on ECS. 


A task definition file for ECS is created through CloudFormation. This file defines the container images used per task in an ECS cluster. These images are obtained from the official X-Ray public ECR. The scorekeep API container image has the API compiled with Gradle. The container image of the Scorekeep frontend container serves the frontend using the nginx proxy server. This server routes requests to paths starting with /api to the API.



Scorekeep application

## Setup Scorekeep application

Steps:

Install the Stack
1. Clone the xray-gettingstarted branch of the Scorekeep repo.
2. Create the stack
    ```
    aws cloudformation create-stack --stack-name scorekeep --capabilities "CAPABILITY_NAMED_IAM" --template-body file://cf-resources.yaml
    ```
3. Wait till the stack is complete. Should take about 5 minutes
    ```
    aws cloudformation describe-stacks --stack-name scorekeep --query "Stacks[0].StackStatus"
    ```

Generate Trace Data
1. Get the URL of the application
    ```
    aws cloudformation describe-stacks --stack-name scorekeep --query "Stacks[0].Outputs[0].OutputValue"
    ```
    Use this URL to display the Scorekeep application

2. Use the web application to generate trace data

View the trace map in the AWS Management Console
1. Open the X-Ray trace map page of the CloudWatch console.  Alternatively you can open the trace map page of the X-Ray console. 



Delete the Stack

1. Delete the Stack
```
aws cloudformation delete-stack --stack-name scorekeep
```

2. Wait for the stack to be deleted
```
aws cloudformation describe-stacks --stack-name scorekeep --query "Stacks[0].StackStatus"
```


## References

https://docs.aws.amazon.com/xray/latest/devguide/aws-xray.html