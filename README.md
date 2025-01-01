# My example Terraform infrastructure standards

When I started to use Terraform I ran into challenges with code dependencies and repeating common code.  To get around these challenges I am using [Terragrunt](https://terragrunt.gruntwork.io/).  Terragrunt is used to structure your Terraform/OpenTofu infrastructure as code to support multiple environments(e.g. dev, test, production) without duplicating code.

This repository uses Terragrunt to address these challenges:

1. Define a standard [directory structure](project-structure.md) for my projects
2. Store a [state file in a s3 bucket](state-file.md) to manage the infrastructure state
3. Reference [resources](resource-lookup.md) that are in different state files
4. How I [control deployment](control-deployment.md) to different environments when you update a common module









