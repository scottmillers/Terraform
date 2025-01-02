# How to reference resources in other Terraform projects

I often need to lookup existing AWS resources. My preferred option is to use the Terragrunt `dependency`. 

## Terragrunt Options

In Terragrunt you can set a dependency on another module.  This will ensure that the module you are calling will be run after the module you are depending on.  You can have that module output the resource you need to lookup and then use that as input to the module you are calling.

Here is the process:

1. Set a dependency on another module

    In the example below the `subnet` depends on the `vpc`.  The `vpc` will output the `vpc_id` which the `subnet` module will use this vpc_id as a input parameter.

    ```
    # terragrunt.hcl in the subnet directory
    dependency "vpc" {
      config_path = "../vpc"
    }

    
    inputs = {
      vpc_id = "${dependency.vpc.outputs.vpc_id}"
    }
    ```
   

    The `vpc` module will output the `vpc_id` like this:

    ```
    # vpc/outputs.tf
    output "vpc_id" {
      value = aws_vpc.default.id
    }
    ```

    The `subnet` module will use the `vpc_id` like this:

    ```
    # subnet/variables.tf
    variable "vpc_id" {
      type = string
    }
    ```

    ```
    # subnet/main.tf
    resource "aws_subnet" "subnet" {
      vpc_id = var.vpc_id
      ...
    }
    ```



## Terraform Option

In Terraform one option is to lookup the resources using the data block and AWS using tags.  

The example below will use he data block to lookup the default VPC.
  ```
    # Get the default VPC
    data "aws_vpc" "default" {
      default = true
    }
  ```

Another options is to reference the resource in an existing state file.

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

    
