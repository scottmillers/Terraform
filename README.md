# Terraform standards

This repository answers the following questions:


1. How to define a standard project directory structure
2. How to reference resources that are found in different state files
3. How to have control deployment to different environments when you update a module
4. Storing a remote state file



## How to define a standard project directory structure

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


## How to reference resources not in your state file

I often need to lookup existing AWS resources.  One option is to lookup the resources in AWS using tags.  Another options is to reference the resource in an existing state file.

1. Use a data block to lookup existing resources 
  The example below will call AWS and lookup the default VPC.
    ```
    # Get the default VPC
    data "aws_vpc" "default" {
      default = true
    }
    ```

2. Reference a local or remote state file

    The following code will reference a local state file

    ```
    data "terraform_remote_state" "vpc" {
      backend = "local"
      config = {
        path = "../vpc/terraform.tfstate"
      }
    }
    ```
    You need to ensure that the state file referenced, in this case vpc,  has an output called `vpc_id`.  To use the `vpc_id` in your module do the following:

    ```
    module "subnet" {
      source = "../../../modules/subnet"
      region = var.region
      profile = "sandbox"
      environment = "dev"
      vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
      cidr_block = "10.0.0.0/19"
    }
    ```

    


## How to control deployment to different environment when you update a module

If a module is modified all environments that reference that module will be updated. If you want to control the deployment of modules to each environment you have two options:


1. Copy the module to a new directory and reference the new directory

    If you want to make a change to the `subnet` module. You would copy the directory to `subnet-v2` and then make the change.  Then reference the new module in the environment that needs the change.

    Here is the new reference

    ```
    module "subnet" {
      source = "../../../modules/subnet-v2"
      region = var.region
      profile = "sandbox"
      environment = "dev"
      vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
      cidr_block = "10.0.0.0/19"
    }
    ```

2. Put the module in GitHub, tag it, and reference the tag
  You need to [setup a GitHub SSH key](#setup-github-ssh-key) to access the remote repository where your modules reside
  
    Steps:
      1. Create a new GitHub repo called `terraform-example-aws-vpc` 
      2. Copy the local vpc module files to GitHub repo and push them
      3. Create a git tag using `git tag v0.1.0` 
      4. Push the tag to the repo `git push origin main v0.1.0`.  
      5. Modify the reference to the module
          ```
          module "vpc" {
              source = "git@github.com:scottmillers/terraform-aws-example-vpc.git?ref=v0.1.0"
              region = var.region
              profile = "sandbox"
              environment = "dev"
              cidr_block = "10.0.0.0/16"
          }
          ```
      6. Rerun the terraform init since the module source has changes

          ```
          module "vpc" {
              source = "git@github.com:scottmillers/terraform-aws-vpc.git?ref=0.1.1"
              region = var.region
              profile = "sandbox"
              environment = "dev"
              cidr_block = "10.0.0.0/16"
          }
          ```


## Setup GitHub SSH key

Steps:
1. Verify you don't already have [existing GitHub SSH keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/checking-for-existing-ssh-keys)

2. To create a new SSH key replace you email with your GitHub email
    ```
    ssh-keygen -t ed25519 -C "scott_millers@hotmail.com"
    ```
3. Start the ssh-agent
    ```
    eval "$(ssh-agent -s)"
    ```

4. Add your SSH private key to the ssh-agent
    ```
    ssh-add ~/.ssh/id_ed25519
    ```

5. Authenticate with GitHub through the CLI
    ```
    gh auth login
    ```

5. Add you SSH public key to your account on GitHub

    ```
    gh ssh-key add ~/.ssh/id_ed25519.pub --type authentication
    ```

6. Verify it works
    ```
    gh repo list
    ```

## References

- [Terragrunt](https://terragrunt.gruntwork.io/) is used to structure your Terraform/OpenTofu infrastructure as code to support multiple environments(e.g. dev, test, production) without duplicating code. 

- How to structure Terraform projects
https://www.youtube.com/watch?v=nMVXs8VnrF4&t=1614s

- Terraform Module Sources
https://developer.hashicorp.com/terraform/language/modules/sources


- GitHub ssh agent
https://docs.github.com/en/authentication/connecting-to-github-with-ssh




