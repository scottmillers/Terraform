# My Terragrunt example

## Pre-requisites

1. Update the bucket parameter in the root.hcl file. We use S3 as a Terraform
   backend to store your state, and S3 bucket names must be globally unique. The name currently in the file is already taken, so you'll have to specify your own. Alternatives, you can set the environment variable TG_BUCKET_PREFIX to set a custom prefix.
2. Update the account_name and aws_account_id parameters in non-prod/account.hcl and
   prod/account.hcl with the names and IDs of accounts you want to use for non production and
   production workloads, respectively.
3. Configure your AWS credentials using one of the supported authentication
mechanisms.
4. GitHub SSH private key with email `git@github.com`


## Setup

1. Go to `terragrunt-example/non-prod/us-east-1/dev/mysql` and type terragrunt plan