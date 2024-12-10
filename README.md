# Terraform Project Structure

This Terraform project structure in 'projects/example' solves a few problems:


1. [How to structure your Terraform so you can deploy to different environments while still getting reuse by using modules](#how-to-have-different-terraform-for-different-deployment-environments)
2. [How to reference resources that are found in different state files](#how-to-reference-terraform-resources-not-in-your-state-file)
3. [How to have a controlled deployment to different environments when you update a module](#how-to-have-a-controlled-deployment-to-different-environment-when-you-update-a-module)



## How to have different terraform for different deployment environments

Go to the `projects/example` directory.  You will see a directory called envs.  For each of your deployment environment make a separate directory. 

## How to reference terraform resources not in your state file

Here are the options:

1. Use a data block to lookup existing resources 

The code below will call AWS and lookup the default VPC.

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

You need to ensure that the statefile referenced, in this case vpc,  has an output called `vpc_id`

## How to have a controlled deployment to different environment when you update a module

If a module is modified all environments that reference that module will be updated. If you want to control the deployment of modules to each environment you have two options:


1. Copy the module to a new directory and reference the new directory

For example, let's say you want to make a change to the `subnet` module. You copy the directory to `subnet-v2` and then make the change.  Then reference the new module in the environment that needs the change.

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

- You need to [setup a GitHub SSH key](#setup-github-ssh-key) to access the remote repository where your modules reside

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

https://www.youtube.com/watch?v=nMVXs8VnrF4&t=1614s

Terraform Module Sources
https://developer.hashicorp.com/terraform/language/modules/sources


GitHub ssh agent
https://docs.github.com/en/authentication/connecting-to-github-with-ssh




