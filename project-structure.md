
# Standard Project Directory Structure

I use Gruntwork's Terragrunt [recommended folder structure](https://docs.gruntwork.io/2.0/docs/overview/concepts/infrastructure-live/).

```
account
 └ _global
 └ region
    └ _global
    └ environment
       └ category
          └ resource
```

- Accounts: At the top level of the folder structure are folders for each of your AWS accounts, such as stage, prod, mgmt, etc. If you have everything deployed in a single AWS account, there will just be a single folder at the root (e.g. main-account).
- Region: Within each account, there will be one or more AWS regions, such as us-east-1, eu-west-1, and ap-southeast-2, where you've deployed resources. There may also be a _global folder that defines resources that are available across all the AWS regions in this account, such as IAM users, Route 53 hosted zones, and CloudTrail.
- Environments: Within each region, there will be one or more "environments", such as qa, stage, etc. Typically, an environment will correspond to a single AWS Virtual Private Cloud (VPC), which isolates that environment from everything else in that AWS account. There may also be a _global folder that defines resources that are available across all the environments in this AWS region, such as Route 53 A records, SNS topics, and ECR repos.
- Categories: Within each Environment, you deploy all the resources for that environment, such as EKS clusters and Aurora databases, using Terraform modules. Groups or similar modules inside an environment are further organized by the overarching category they relate to, such as networking (VPCs) and services (EKS workers).

For my development work this would be `non-prod` account or my sandbox account with no restrictions and a `prod` account which is my case is an Advanced Cloud account
```
non-prod
 └ _global
 └ us-east-1
    └ _global
    └ dev
       └ network
          └ resource
prod
 └ _global
 └ us-east-1
    └ _global
    └ dev
       └ network
          └ resource
```
