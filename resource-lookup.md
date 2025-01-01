# How to reference resources not in your state file

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

    
