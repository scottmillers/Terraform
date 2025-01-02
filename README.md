# Terraform Infrastructure Examples using Terragrunt

When I started to use Terraform I ran into challenges with dependencies between projects and repeating terraform code.  To get around these challenges I use [Terragrunt](https://terragrunt.gruntwork.io/).  

Terragrunt is used to structure your Terraform infrastructure projects to support multiple environments(e.g. dev, test, production) without duplicating code.

This repository explores Terragrunt to address these challenges:

1. How to define a [standard directory structure](project-structure.md) for my projects that support different environments(e.g. dev, test, prod) while sharing common Terraform modules
2. How to store a [state file in a s3 bucket](state-file.md) in a common location for multiple terraform projects
3. How to [lookup resources](resource-lookup.md) not in your Terraform projects state file
4. How to [control deployment](control-deployment.md) to different environments when you update a common module


These standards are all used in my [terragrunt-example](projects/terragrunt-example/) project.







