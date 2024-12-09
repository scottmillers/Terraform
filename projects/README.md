# My Terraform Projects

This directory contains a structure that I use for Terraform. It solves a few problems.

1. How to manage the terraform for different environments
2. How to referencing resources that you need that are not in your state file
3. How to manage changes to your modules 



## How to manage the terraform for different environments

Under the project name you will see a directory called envs.  Each environment has a separate directory.

## How to reference Terraform resources not in your state file

Here are the options:

1. Use a data block to lookup existing resources 

Use the data block to lookup existing AWS resources.

```
# Get the default VPC
data "aws_vpc" "default" {
  default = true
}

```

2. Reference the location of your local state file

Use a reference to a local state file or a remote state file.  

The example project uses this approach. The subnet directory needs the VPC id.  The data.tf has this code:

```
data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
   path = "../vpc/terraform.tfstate"
  }
}
```

This is then referenced in the subnet like follows:

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

You need to ensure that the vpc has an output called `vpc_id`

## How to manage changes to your modules

If a module is modified all environments that reference that module will be updated. If you want to control the deployment of module changes in each environment you will have two options

1. Copy the module to a new directory and reference the new module directory

For example, let's say you want to make a change to the `subnet` module. You copy the directory to `subnet-v2` and then make the change.  Then reference the new module one environment at a time to verify it works.

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

Create a new GitHub repo called `terraform-aws-vpc` and copy the local vpc module.  Clone the module locally.  Create a git tag using `git tag 0.1.0` and then use `git push origin main --tags`.  When you reference the module use

```
module "vpc" {
    source = "git@github.com:scottmillers/terraform-aws-vpc.git?ref=0.1.0"
    region = var.region
    profile = "sandbox"
    environment = "dev"
    cidr_block = "10.0.0.0/16"
}
```

You then modify the vpc module.  Commit it. Then create a new tag `git tag 0.1.1`.  Then reference the new module using 

```
module "vpc" {
    source = "git@github.com:scottmillers/terraform-aws-vpc.git?ref=0.1.1"
    region = var.region
    profile = "sandbox"
    environment = "dev"
    cidr_block = "10.0.0.0/16"
}
```


## References

https://www.youtube.com/watch?v=nMVXs8VnrF4&t=1614s






