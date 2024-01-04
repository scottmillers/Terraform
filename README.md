<img src="docs/images/terraform.svg" width="100" height="100">

# My Terraform Examples
[Terraform](https://www.terraform.io/) automates your infrastructure deployments using code. 

This repository contains my Terraform code to deploy infrastructure on AWS and Azure. 

## AWS

- [Route53 Failover Prototype ](./aws/route53)
   This prototype uses Route 53 DNS failover policies to test a failover across two AWS regions. It uses Terraform to create the infrastructure and shell scripts to cause a failure of the primary region EC2 instance.  When the failure occurs the Route 53 health check recognize the failure and return the records for the EC2 in the secondary region. The goal is to understand how Route 53 DNS failover works and how the configuration parameters affect the failover time.
- [EventBridge Filter Prototype](./eventbridge/01-lambda-atm)
    This prototype use EventBridge to filter ATM transactions and depending on the EventBridge rule put the transaction into different Dynamodb tables. 
- [CloudFront Example ](./cloudfront)
- [S3 Lifecycle Example ](./s3/life-cycle)

## Azure

- [Private Resolver Prototype](./azure/private-resolver-prototype/) 
This prototype creates the Azure infrastructure to test a [Azure private resolver](https://docs.microsoft.com/en-us/azure/dns/private-dns-overview).

