# Edge-Optimized API Gateway

- API Gateway is a fully managed service that makes it easy for developers to create, publish, maintain, monitor, and secure APIs at any scale.

- Edge-optimized APIs are endpoints that are accessed through a CloudFront distribution created and managed by API Gateway.

- Edge-optimized APIs are intended for public clients accessing the API over the Internet.

Question 24:
You have created the main Edge-Optimized API Gateway in us-west-2 AWS region. This main Edge-Optimized API Gateway forwards traffic to the second level API Gateway in ap-southeast-1. You want to secure the main API Gateway by attaching an ACM certificate to it. Which AWS region are you going to create the ACM certificate in?

Answer: us-east-1

Why? Because the main Edge-Optimized API Gateway is in us-west-2. The ACM certificate must be in the us-east-1 region. The ACM certificate must be in the us-east-1 region because the CloudFront distribution is in the us-east-1 region. The CloudFront distribution is in the us-east-1 region because the CloudFront distribution is created by API Gateway. The CloudFront distribution is created by API Gateway because the main Edge-Optimized API Gateway is an Edge-Optimized API Gateway. Edge-Optimized API Gateways create CloudFront distributions in the us-east-1 region.