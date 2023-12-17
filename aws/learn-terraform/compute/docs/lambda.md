# AWS Lambda

- A serverless compute service.
- Lambda executes your code only when needed and scales automatically.
- Lambda functions are stateless – no affinity to the underlying infrastructure.
- You choose the amount of memory you want to allocate to your functions and AWS Lambda allocates proportional CPU power, network bandwidth, and disk I/O.
- AWS Lambda is SOC, HIPAA, PCI, ISO compliant.
- Natively supports the following languages:
    - Node.js
    - Java
    - C#
    - Go
    - Python
    - Ruby
    - PowerShell
- You can also provide your own custom runtime.


## Components of a Lambda Application


- Layers – Lambda layers are a distribution mechanism for libraries, custom runtimes, and other function dependencies. Layers let you manage your in-development function code independently from the unchanging code and resources that it uses.



## Lambda Functions

- Conﬁgure basic function settings, including the description, memory usage, storage (512MB – 10GB), execution timeout (15 minutes max), and the role that the function will use to execute your code.

- Versions – a snapshot of your function’s state at a given time. When you publish a new version, a :version-number is appended to your function’s ARN:
arn:aws:lambda:us-east-2:123456789123:function:my-function:1

## Invoking Lambda Functions

- Lambda supports synchronous and asynchronous invocation of a Lambda function.

## Concurrency Management

- To ensure that a function can always reach a certain level of concurrency, you can configure the function with reserved concurrency. When a function has reserved concurrency, no other function can use that concurrency. Reserved concurrency also limits the maximum concurrency for the function.
- To enable your function to scale without fluctuations in latency, use provisioned concurrency. By allocating provisioned concurrency before an increase in invocations, you can ensure that all requests are served by initialized instances with very low latency.

## Lambda Function URL

- With the function URL feature of the AWS Lambda service, you can launch a secure HTTPS endpoint dedicated to your custom Lambda function.

- You don’t need an intermediary service such as Amazon API Gateway to directly invoke your function, which was required in the past. Just send an HTTP request to the unique URL of your Lambda function to get started.

- Function URL endpoints are publicly accessible by default and have the following format:
https://<url-id>.lambda-url.<region>.on.aws

- You can access your function URL through the public Internet only and not via AWS PrivateLink (e.g., VPC Endpoints)

- Uses resource-based policies for security and access control. You can further secure your function URL by enabling cross-origin resource sharing (CORS) to whitelist origins permitted to invoke it.

## References


https://tutorialsdojo.com/aws-lambda/

URLs
https://docs.aws.amazon.com/lambda/latest/dg/urls-configuration.html

https://docs.aws.amazon.com/lambda/latest/dg/lambda-urls.html

Scaling
https://aws.amazon.com/blogs/startups/from-0-to-100-k-in-seconds-instant-scale-with-aws-lambda/
https://docs.aws.amazon.com/lambda/latest/dg/invocation-scaling.html
