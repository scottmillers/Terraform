# Terragrunt Quick Start

This is the project for the [Terragrunt quick start tutorial](https://terragrunt.gruntwork.io/docs/getting-started/quick-start/)

It shows the following constructs

- Two terragrunt units called foo and bar call the shared module
- A shared module with a main.tf that creates a file with input from the units
- Inputs that are passed from the terragrunt.hcl files in foo and bar to the shared module
- Ability to manage a "stack" or a collection of units that are managed together.  A stack is a single environment, such as dev, staging, prod, or an entire project.
- Use run.sh to run both foo and bar
- Ability to manage your DAG, or Directed Acyclic Graph(DAG), which runs across your stack. In this example we make bar dependent on foo and put the output from foo in bar