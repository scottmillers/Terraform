# How to control deployment to different environment when you update a module

If a module is modified all environments that reference that module will be updated. If you want to control the deployment of modules to each environment you have two options:


1. Put the module in GitHub, tag it, and reference the tag
  You need to [setup a GitHub SSH key](#github-ssh) to access the remote repository where your modules reside
  
    Steps:
      1. Create a new GitHub repo called `terraform-infrastructure-modules-examples` 
      2. Copy the local vpc module files to GitHub repo and push them
      3. Create a git tag using `git tag v0.1.0` 
      4. Push the tag to the repo `git push origin main v0.0.1`.  
      5. Modify the reference to the module
          ```
          module "vpc" {
              source = "https://github.com/scottmillers/terragrunt-infrastructure-modules-examples.git//modules/vpc?ref=v0.0.1"
              name = "demo"
              cidr_block = "10.0.0.0/16"
          }
          ```
      6. Rerun the terraform init since the module source has changes



2. Copy the module to a new directory and reference the new directory

    If you want to make a change to the `subnet` module. You would copy the directory to `subnet-v2` and then make the change.  Then reference the new module in the environment that needs the change.

    Here is the new reference

    ```
    module "subnet" {
      source = "../../../modules/subnet-v2"
      name = "demo"
      vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
      cidr_block = "10.0.0.0/19"
    }
    ```

