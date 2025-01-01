# How to control deployment to different environment when you update a module

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

